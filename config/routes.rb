Rails.application.routes.draw do
  devise_for :users
  root "movies#index"
  resources :movies
  resources :ratings, only: :create

  authenticated do
    root to: "secret#index", as: :authenticated_root
  end
end
