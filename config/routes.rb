# == Route Map
#

Rails.application.routes.draw do
  namespace :admin do
    resources :users
  end

  get "up" => "rails/health#show", as: :rails_health_check
  get "/pages/:page" => "pages#show"

  get 'trudnosci' => 'pages#dificulties_table'

  root "pages#dificulties_table"
end
