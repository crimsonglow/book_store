class CreateBookImages < ActiveRecord::Migration[7.0]
  def change
    create_table :book_images do |t|
      t.text :image_data, unique: true
      t.integer :image_type, default: 0
      t.belongs_to :book, foreign_key: { on_delete: :cascade }, null: true, unique: false
      t.timestamps
    end
  end
end
