class CreateBookAuthors < ActiveRecord::Migration[7.0]
  def change
    create_table :book_authors do |t|
      t.belongs_to :book, foreign_key: true, null: false, unique: true
      t.belongs_to :author, foreign_key: true, null: false, unique: true

      t.timestamps
    end
  end
end
