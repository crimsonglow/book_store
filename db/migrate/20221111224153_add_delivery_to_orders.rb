class AddDeliveryToOrders < ActiveRecord::Migration[7.0]
  def change
    add_reference :orders, :delivery, foreign_key: true, null: true, unique: true
  end
end
