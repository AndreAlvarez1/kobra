Rails.application.routes.draw do
  resources :buyers
  resources :products
  devise_for :sellers, controllers: {
    registrations: 'sellers/registrations'
  }

  get 'pages/home'
  get 'pages/index'
  get 'pages/dashboard'

  root 'pages#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
