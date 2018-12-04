Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  resources :events
  get 'orders/index'

  resources :buyers do
    resources :orders, only: [:create]
    resources :products, only: [:index]

  end

  resources :products
  resources :orders

  resources :billings, only:[:index] do
    collection do
      get 'pre_pay'
      get 'execute/:buyer_id', to: 'billings#execute'
    end
  end

  devise_for :sellers, controllers: {
    registrations: 'sellers/registrations',
    sessions: 'sellers/sessions'
  }
  root to: 'pages#index'
  get 'pages/home'
  get 'pages/index'
  get 'pages/dashboard'
  get 'pages/calendar'
  get 'pages/modal'
  get 'pages/success'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
