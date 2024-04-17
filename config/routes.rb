Rails.application.routes.draw do
  mount MissionControl::Jobs::Engine, at: "/jobs"

  resources :mountain_routes, path: 'przejscia'
  resources :app_settings, path: "konfiguracja"

  resources :users, only: [:show, :destroy]

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
  get 'polityka-prywatnosci' => 'pages#polityka_prywatnosci'
  get 'regulamin' => 'pages#regulamin'
  get 'admin' => 'pages#admin'
  get 'przejscia' => 'mountain_routes#index'

  root "mountain_routes#index"
end
