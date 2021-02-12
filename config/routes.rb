Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users

  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  post '/send_request', to: 'friendships#create'
  post 'users/accept', to: 'friendships#update'
  get 'friend_requests',to: 'friendships#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
