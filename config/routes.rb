# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'frontend/home#index'

  scope module: 'frontend' do
    resources :countries, path: '', param: :user_country, only: :show do
      resources :cities, path: '', param: :user_city, only: :show do
        resources :posts
      end
    end
  end

  namespace :backend, path: 'admin' do
  end
end
