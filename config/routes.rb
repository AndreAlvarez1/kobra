Rails.application.routes.draw do
  resources :buyers
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
