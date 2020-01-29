Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
namespace :api do
  namespace :v1 do
    post '/users', to: 'users#signup' 
    post '/users', to: 'users#login' 
    get '/users', to: 'users#index'
  end
end
end
