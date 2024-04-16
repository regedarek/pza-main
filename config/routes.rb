Rails.application.routes.draw do
  resources :mountain_routes, path: 'przejscia'

  resources :users, only: [:show]

  namespace :admin do
    resources :users
  end

  namespace :messaging do
    resources :comments, only: [:create, :update, :destroy]
  end

  resource :session, only: [:new, :create, :destroy]
  resource :registration, only: [:new, :create]
  resource :password_reset, only: [:new, :create, :edit, :update]
  resource :password, only: [:edit, :update]

  get "up" => "rails/health#show", as: :rails_health_check
  get "/pages/:page" => "pages#show"

  get 'trudnosci' => 'pages#dificulties_table'
  get 'admin' => 'pages#admin'
  get 'przejscia' => 'mountain_routes#index'

  root "mountain_routes#index"
end
