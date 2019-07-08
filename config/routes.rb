Rails.application.routes.draw do
  
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', sessions: 'sessions/sessions'  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "pages#index"
  resources :users, only: [:show, :index]
  resources :posts, only: [:create]
  resources :comments, only: [:create]
  resources :likes, only: [:create]
  resources :profiles, only: [:create, :update]
  resources :invitations, only: [:create]
end
