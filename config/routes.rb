Rails.application.routes.draw do
  get 'chatroom/index'
  resources :users, only: [:new, :create]
  root 'chatroom#index'
  get 'login', to: 'users#login'
  post 'login', to: 'users#create_login_session'

  delete '/logout', to: 'users#destroy', as: 'logout'
  post 'create_login_session', to: 'users#create_login_session', as: :create_login_session

  resources :messages, only: [:create]
  mount ActionCable.server => '/cable'
end
