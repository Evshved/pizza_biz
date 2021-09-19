class CreatePizzaTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :pizza_types do |t|
      t.string :name
      t.decimal :price
      t.timestamps
    end
  end
end
