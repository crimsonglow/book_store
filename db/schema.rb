# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 20_221_118_103_337) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'active_admin_comments', force: :cascade do |t|
    t.string 'namespace'
    t.text 'body'
    t.string 'resource_type'
    t.bigint 'resource_id'
    t.string 'author_type'
    t.bigint 'author_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[author_type author_id], name: 'index_active_admin_comments_on_author'
    t.index ['namespace'], name: 'index_active_admin_comments_on_namespace'
    t.index %w[resource_type resource_id], name: 'index_active_admin_comments_on_resource'
  end

  create_table 'addresses', force: :cascade do |t|
    t.string 'first_name'
    t.string 'last_name'
    t.string 'address'
    t.string 'city'
    t.integer 'zip'
    t.string 'country'
    t.string 'phone'
    t.integer 'address_type'
    t.integer 'resource_id'
    t.string 'resource_type'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['resource_id'], name: 'index_addresses_on_resource_id'
    t.index ['resource_type'], name: 'index_addresses_on_resource_type'
  end

  create_table 'admin_users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_admin_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_admin_users_on_reset_password_token', unique: true
  end

  create_table 'authors', force: :cascade do |t|
    t.string 'first_name'
    t.string 'last_name'
    t.string 'description'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'book_authors', force: :cascade do |t|
    t.bigint 'book_id'
    t.bigint 'author_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['author_id'], name: 'index_book_authors_on_author_id'
    t.index ['book_id'], name: 'index_book_authors_on_book_id'
  end

  create_table 'books', force: :cascade do |t|
    t.string 'title'
    t.text 'description'
    t.string 'photo'
    t.integer 'published_year'
    t.float 'heigth'
    t.float 'width'
    t.float 'depth'
    t.string 'material'
    t.decimal 'price'
    t.bigint 'category_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.text 'image_data'
    t.index ['category_id'], name: 'index_books_on_category_id'
  end

  create_table 'categories', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'coupons', force: :cascade do |t|
    t.string 'key'
    t.decimal 'discount', default: '10.0'
    t.bigint 'order_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['order_id'], name: 'index_coupons_on_order_id'
  end

  create_table 'credit_cards', force: :cascade do |t|
    t.string 'number'
    t.string 'name'
    t.string 'date'
    t.integer 'cvv'
    t.bigint 'order_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['order_id'], name: 'index_credit_cards_on_order_id'
  end

  create_table 'deliveries', force: :cascade do |t|
    t.string 'method'
    t.integer 'from_days'
    t.integer 'to_days'
    t.decimal 'price'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'line_items', force: :cascade do |t|
    t.integer 'quantity', default: 0
    t.bigint 'book_id'
    t.bigint 'order_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['book_id'], name: 'index_line_items_on_book_id'
    t.index ['order_id'], name: 'index_line_items_on_order_id'
  end

  create_table 'orders', force: :cascade do |t|
    t.integer 'status', default: 0
    t.string 'number'
    t.bigint 'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.bigint 'delivery_id'
    t.index ['delivery_id'], name: 'index_orders_on_delivery_id'
    t.index ['user_id'], name: 'index_orders_on_user_id'
  end

  create_table 'reviews', force: :cascade do |t|
    t.string 'title'
    t.text 'text_review'
    t.integer 'rating', default: 0
    t.integer 'status', default: 0
    t.boolean 'is_verified', default: false
    t.bigint 'user_id'
    t.bigint 'book_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['book_id'], name: 'index_reviews_on_book_id'
    t.index ['user_id'], name: 'index_reviews_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.integer 'sign_in_count', default: 0, null: false
    t.datetime 'current_sign_in_at'
    t.datetime 'last_sign_in_at'
    t.string 'current_sign_in_ip'
    t.string 'last_sign_in_ip'
    t.string 'confirmation_token'
    t.datetime 'confirmed_at'
    t.datetime 'confirmation_sent_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'provider'
    t.string 'uid'
    t.index ['confirmation_token'], name: 'index_users_on_confirmation_token', unique: true
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  add_foreign_key 'books', 'categories'
  add_foreign_key 'coupons', 'orders'
  add_foreign_key 'credit_cards', 'orders'
  add_foreign_key 'line_items', 'books'
  add_foreign_key 'line_items', 'orders'
  add_foreign_key 'orders', 'deliveries'
  add_foreign_key 'orders', 'users'
  add_foreign_key 'reviews', 'books'
  add_foreign_key 'reviews', 'users'
end
