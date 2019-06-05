# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :v1 do
    post 'users/sign_in' => 'users#sign_in'
    post 'users/sign_out' => 'users#sign_out'
  end
end
