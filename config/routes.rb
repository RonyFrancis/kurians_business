# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'v1/bills#welcome'
  namespace :v1 do
    post 'users/sign_in' => 'users#sign_in'
    post 'users/sign_out' => 'users#sign_out'
    post 'password/recover_password' => 'password#recover_password'
    post 'password/change_password' => 'password#change_password'
    get  '/status' => 'bills#welcome'
    resources :user_profile
    resources :registrations, only: [:create]
    resources :bills, only: [:index, :create]
  end
end
