Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks", registrations: 'users/registrations' }

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  root 'home#index'

  resources :books
  resources :addresses
  resources :categories do
    resources :books, :index
  end
  resources :line_items
  resources :orders
  resources :addresses
  resources :reviews
  resources :settings
  resources :settings_emails
  resources :accounts
  resources :coupons
  resources :checkout, param: :step
  resources :carts, path: '/carts/line_items'
end
