# frozen_string_literal: true

module Discounts
  class PriceCalculator
    def initialize(order_items)
      @order_items = order_items
    end

    def calculate
      price = 0
      @order_items.each do |order_item|
        price += order_item[:price] * order_item[:quantity].to_i
      end
      discount_amount = discounts_checker(price) * price
      { discount_amount: discount_amount.truncate(2), amount_with_discount: price - discount_amount.truncate(2) }
    end

    private

    def discounts_checker(amount)
      return 0.05 if amount > 50

      0
    end
  end
end
