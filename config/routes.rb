Rails.application.routes.draw do
  resources :events
  get 'orders/index'

  resources :buyers do
    resources :orders, only: [:create]
    resources :products, only: [:index]

  end

  resources :products
  resources :orders

  resources :billings, only:[] do
    collection do
      get 'pre_pay'
    end
  end

  devise_for :sellers, controllers: {
    registrations: 'sellers/registrations'
  }
  root to: 'pages#index'
  get 'pages/home'
  get 'pages/index'
  get 'pages/dashboard'
  get 'pages/calendar'
  get 'pages/modal'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
