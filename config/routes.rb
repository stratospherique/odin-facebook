Rails.application.routes.draw do
  
  get 'notifications/index'
  get 'invitations/index'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', sessions: 'sessions/sessions'  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  authenticated do
    root :to => 'posts#index'
  end
  root to: "pages#index"
  resources :users, only: [:show, :index]
  resources :posts, only: [:create, :index]
  resources :comments, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]
  resources :profiles, only: [:create, :update]
  resources :invitations, only: [:create, :destroy, :update]
  get 'likes/:id', to: "likes#delete", as: 'destruction'
  get 'comments/:id/:source', to: "comments#dest", as: 'tim_com_del'
end
