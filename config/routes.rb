# frozen_string_literal: true

Rails.application.routes.draw do
  resources :pizzas_order, only: %i[index create] do
    collection do
      post :order_items
    end
  end
  resources :pizza_menu, only: [:index]
  namespace :api do
    resources :pizza_orders, only: %i[index show]
  end
  root 'pizza_menu#index'
end
