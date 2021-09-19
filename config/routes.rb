Rails.application.routes.draw do

  resources :pizzas_order, only: [:index, :create]
  resources :pizza_menu, only: [:index, :create]
  namespace :api do
    resources :pizza_orders, only: [:index, :create]
  end  
end
