class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title
      t.text :description
      t.integer :published_year
      t.float :heigth
      t.float :width
      t.float :depth
      t.string :material
      t.decimal :price

      t.belongs_to :category, foreign_key: true, null: false, unique: true

      t.timestamps
    end
  end
end
