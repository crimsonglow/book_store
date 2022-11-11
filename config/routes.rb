Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

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
end
