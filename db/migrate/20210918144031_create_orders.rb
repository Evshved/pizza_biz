class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer 'order_items', array: true
      t.timestamps
    end
  end
end
