class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :city
      t.integer :zip
      t.string :country
      t.string :phone
      t.integer :address_type
      t.bigint :resource_id, index: true, null: false
      t.string :resource_type, index: true, null: false

      t.timestamps
    end
  end
end
