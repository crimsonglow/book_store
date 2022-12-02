class CreateCoupons < ActiveRecord::Migration[7.0]
  def change
    create_table :coupons do |t|
      t.string :key
      t.decimal :discount, default: 10

      t.belongs_to :order, foreign_key: { on_delete: :nullify }, null: true, unique: true

      t.timestamps
    end
  end
end
