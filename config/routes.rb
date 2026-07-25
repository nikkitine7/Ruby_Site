Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root "products#index"

  resources :products, only: %i[index show] do
    post :add_to_cart, on: :member
  end

  resources :users, only: %i[new create]
  resource :session, only: %i[new create destroy]
  resources :contact_messages, only: %i[new create]

  resource :cart, only: %i[show] do
    delete :remove, on: :member
  end

  resources :orders, only: %i[new create show] do
    get :success, on: :member
  end

  namespace :admin do
    get "products/index"
    get "products/new"
    get "products/create"
    get "products/edit"
    get "products/update"
    get "products/destroy"
    get "dashboard/index"
    get "/", to: "dashboard#index", as: :dashboard
    resources :products
  end
end
