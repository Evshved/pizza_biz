# frozen_string_literal: true

class PizzasOrderController < ApplicationController
  def index
    # @order_items = PizzaType.where(id: ids)
    # @price = Discounts::PriceCalculator.new(price)
    # respond_to { |format| format.html }
  end

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
end
