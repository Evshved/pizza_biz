# frozen_string_literal: true

class Api::PizzaOrdersController < ApplicationController
  def index
    orders = Order.joins(:order_items).last(50).map do |elem|
      [elem.id, elem.order_items.ids]
    end
    render status: 200, json: orders
  end

  def show
    permitted_param = params.permit(:id)
    order_item = OrderItem.find(permitted_param[:id])
    render status: 200, json: { id: order_item.id, order_id: order_item.order_id, quantity: order_item.quantity }
  end
end
