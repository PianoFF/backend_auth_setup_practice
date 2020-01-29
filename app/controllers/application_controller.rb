class ApplicationController < ActionController::API

  before_action :authorized

  def encode_token(payload)
    JWT.encode(payload, 'my-big-secret')
  end

  def auth_header
    request.headers['Authorization'] || request.headers['Authorisation']
  end

  def decode_token
    if auth_header
      token = auth_header.split(' ')[1]
      begin
        JWT.decode(token, 'my-big-secret')
      rescue JWT::DecodeError
        nil
      end
    end
  end
  
  def authorized
      render json: { message: "Please make sure you are logged in. \n Don't have an account? sign up"} unless logged_in?
  end

  def current_user
    if decode_token
      user_id = decode_token[0]['user_id']
      user = User.find_by(id: user_id)
    end
  end
  
  def logged_in?
    !!current_user
  end

end
