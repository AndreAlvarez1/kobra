Rails.application.routes.draw do
  get 'orders/index'

  resources :buyers do
    resources :orders, only: [:create]
    resources :products, only: [:index]

  end

  resources :products

  devise_for :sellers, controllers: {
    registrations: 'sellers/registrations'
  }
  root to: 'pages#index'
  get 'pages/home'
  get 'pages/index'
  get 'pages/dashboard'
  get 'pages/modal'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
