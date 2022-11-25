class CreateDeliveries < ActiveRecord::Migration[7.0]
  def change
    create_table :deliveries do |t|
      t.string :method
      t.integer :from_days
      t.integer :to_days
      t.decimal :price

      t.timestamps
    end
  end
end
