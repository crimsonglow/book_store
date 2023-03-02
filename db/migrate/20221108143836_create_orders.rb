class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.integer :status, default: 0
      t.string :number
      t.belongs_to :user, foreign_key: true, null: true, unique: true

      t.timestamps
    end
  end
end
