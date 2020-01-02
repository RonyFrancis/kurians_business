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
    post 'user_profile/update_status' => 'user_profile#update_status'
    resources :user_profile
    resources :registrations, only: [:create]
    resources :bills, only: [:index, :create]
  end
  get '*path', to: 'application#frontend_index_html', constraints: lambda { |request|
      !request.xhr? && request.format.html?
  }
end
