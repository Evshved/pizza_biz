# frozen_string_literal: true

class PizzasOrderController < ApplicationController
  def index; end

  def create
    order_item_ids = []
    order_price = 0
    params.each do |_elem|
      order_item = OrderItem.create(pizza_type: type, quantity: quantity)
      if order_item
        order_item_ids << order_item.id
        order_price += order_item.price
      end
    end
    price = Discounts::PriceCalculator.new(price)

    order = Order.new(ids: order_item_ids, price: price)
    respond_to if order.save
  end

  def order_items
    pizza_orders = []
    permitted_params.each do |key, value|
      pizza_types.select do |type|
        pizza_orders << { name: type.name, price: type.price, quantity: value } if type.name == key.capitalize
      end
    end

    respond_to do |format|
      format.json { render json: { success: true, html: (render_to_string partial: 'pizzas_order/order_items.html.erb', locals: { pizza_orders: pizza_orders }) } }
    end
  end

  private

  def pizza_types
    @pizza_types ||= PizzaType.all
  end

  def pizza_type_names
    @pizza_type_names ||= pizza_types.pluck(:name).map { |e| e.downcase.to_sym }
  end

  def permitted_params
    params.permit(pizza_type_names)
  end
end
