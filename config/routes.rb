Rails.application.routes.draw do
  resources :mountain_routes
  namespace :admin do
    resources :users
  end

  resource :session, only: [:new, :create, :destroy]
  resource :registration, only: [:new, :create]
  resource :password_reset, only: [:new, :create, :edit, :update]
  resource :password, only: [:edit, :update]

  get "up" => "rails/health#show", as: :rails_health_check
  get "/pages/:page" => "pages#show"

  get 'trudnosci' => 'pages#dificulties_table'

  root "pages#dificulties_table"
end
