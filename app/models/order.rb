# frozen_string_literal: true

class Order < ApplicationRecord
  serialize :state_ids
  has_many :order_items
end
