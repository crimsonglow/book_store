class CreateCreditCards < ActiveRecord::Migration[7.0]
  def change
    create_table :credit_cards do |t|
      t.string :number
      t.string :name
      t.string :date
      t.integer :cvv
      t.belongs_to :order, foreign_key: true

      t.timestamps
    end
  end
end
