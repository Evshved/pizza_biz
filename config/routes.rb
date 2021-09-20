Rails.application.routes.draw do
  resources :pizzas_order, only: [:index, :create]
  resources :pizza_menu, only: [:index]
  namespace :api do
    resources :pizza_orders, only: [:index, :create]
  end
  root 'pizza_menu#index'
end
