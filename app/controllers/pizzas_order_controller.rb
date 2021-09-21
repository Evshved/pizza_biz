# frozen_string_literal: true

class PizzasOrderController < ApplicationController
  def index; end

  def create
    pizza_orders = pizza_orders_filter
    order_items = []

    ActiveRecord::Base.transaction do
      order = Order.create
      pizza_orders.each do |elem|
        type = pizza_types.find { |type| type[:name] == elem[:name] }
        next if type.nil?

        order_item = OrderItem.create(pizza_type_id: type.id, quantity: elem[:quantity], order_id: order.id)
        order_items << order_item if order_item
      end
    end

    render status: 200, json: {}
  end

  def order_items
    pizza_orders = pizza_orders_filter
    price_calculations = price_calculations(pizza_orders)
    respond_to do |format|
      format.json do
        render json: { success: true, html: (render_to_string partial: 'pizzas_order/order_items.html.erb', locals: { pizza_orders: pizza_orders,
                                                                                                                      discount: price_calculations[:discount_amount],
                                                                                                                      amount_with_discount: price_calculations[:amount_with_discount] }) }
      end
    end
  end

  private

  def pizza_orders_filter
    pizza_orders = []
    permitted_params.each do |key, value|
      pizza_types.select do |type|
        pizza_orders << { name: type.name, price: type.price, quantity: value } if type.name == key.capitalize
      end
    end
    pizza_orders
  end

  def price_calculations(pizza_orders)
    Discounts::PriceCalculator.new(pizza_orders).calculate
  end

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
