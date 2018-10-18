Rails.application.routes.draw do
  get 'buyers/preorders'

  resources :buyers do
    resources :orders, only: :create
  end
  
  resources :products
  devise_for :sellers, controllers: {
    registrations: 'sellers/registrations'
  }
  root 'pages#index'
  get 'pages/home'
  get 'pages/index'
  get 'pages/dashboard'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
