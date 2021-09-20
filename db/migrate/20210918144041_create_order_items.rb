# frozen_string_literal: true

class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.belongs_to :pizza_type, null: false, foreign_key: true
      t.belongs_to :order, null: false, foreign_key: true, index: true
      t.integer :quantity
      t.timestamps
    end
  end
end
