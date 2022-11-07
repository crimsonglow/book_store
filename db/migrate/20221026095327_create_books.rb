class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :checkbox
      t.string :title
      t.text :short_description
      t.decimal :price
      t.string :image

      t.belongs_to :category, foreign_key: true

      t.timestamps
    end
  end
end
