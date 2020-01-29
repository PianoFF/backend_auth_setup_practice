class Api::V1::UsersController < ApplicationController
  skip_before_action :authorized, only: [:signup]

  def signup
    user = User.create(user_params)
    # byebug
    if user.valid?
      token = encode_token(user_id: user.id)
      # byebug
      render json: { user: UserSerializer.new(user), jwt: token }, status: :created
    else
      # byebug
      render json: { error: 'failed to create a new user' }, status: :not_acceptable
    end
  end
  
  def login 
    user = User.find_by(username: user_params[:username])

    if user && user.authenticate(user_params[:password])
      token = encode_token(user_id: user.id)
      render json: { user: UserSerializer.new(user), jwt: token }, status: :created
    else
       render json: { error: 'Something went terribly wrong. Please try again.' }, status: :unauthorized
    end
  end 

  
  def index
    users = User.all 

    render json: users 
  end

  private
  def user_params
    params.require(:user).permit(:username, :password, :bio, :avatar)
  end


end
