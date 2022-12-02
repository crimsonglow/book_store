class CreateLineItems < ActiveRecord::Migration[7.0]
  def change
    create_table :line_items do |t|
      t.integer :quantity, default: 0

      t.belongs_to :book, foreign_key: true, null: false, unique: true
      t.belongs_to :order, foreign_key: true, null: true, unique: true

      t.timestamps
    end
  end
end
