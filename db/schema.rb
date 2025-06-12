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

ActiveRecord::Schema[8.0].define(version: 2025_06_12_093251) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "account_settings", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_account_settings_on_account_id"
  end

  create_table "accounts", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "slug"
    t.string "logo"
    t.string "website"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cover_image"
    t.index ["slug"], name: "index_accounts_on_slug", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "buyers", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "name"
    t.string "slug"
    t.text "description"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cover_image"
    t.string "category"
    t.string "status"
    t.string "access_visibility"
    t.string "location_type"
    t.text "entry_requirement"
    t.integer "step"
    t.string "public_reference"
    t.index ["account_id"], name: "index_events_on_account_id"
    t.index ["slug"], name: "index_events_on_slug", unique: true
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "quantity", default: 1
    t.decimal "unit_price"
    t.bigint "order_id", null: false
    t.bigint "ticket_type_id", null: false
    t.bigint "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_order_items_on_account_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["ticket_type_id"], name: "index_order_items_on_ticket_type_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "reference"
    t.string "status"
    t.decimal "total_amount"
    t.bigint "event_id", null: false
    t.bigint "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "validated_by_id"
    t.boolean "tickets_generated", default: false
    t.index ["account_id"], name: "index_orders_on_account_id"
    t.index ["event_id"], name: "index_orders_on_event_id"
    t.index ["validated_by_id"], name: "index_orders_on_validated_by_id"
  end

  create_table "payments", force: :cascade do |t|
    t.string "payment_method"
    t.string "amount"
    t.bigint "order_id", null: false
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "buyer_email"
    t.string "buyer_phone"
    t.index ["order_id"], name: "index_payments_on_order_id"
  end

  create_table "ticket_type_validators", force: :cascade do |t|
    t.bigint "validator_id", null: false
    t.bigint "ticket_type_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_type_id"], name: "index_ticket_type_validators_on_ticket_type_id"
    t.index ["validator_id"], name: "index_ticket_type_validators_on_validator_id"
  end

  create_table "ticket_types", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.text "description"
    t.string "name"
    t.decimal "price"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_ticket_types_on_event_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "ticket_type_id", null: false
    t.datetime "validity_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "event_id", null: false
    t.boolean "active", default: true
    t.datetime "validated_at"
    t.string "reference"
    t.bigint "order_id"
    t.bigint "validator_id"
    t.index ["account_id"], name: "index_tickets_on_account_id"
    t.index ["event_id"], name: "index_tickets_on_event_id"
    t.index ["order_id"], name: "index_tickets_on_order_id"
    t.index ["ticket_type_id"], name: "index_tickets_on_ticket_type_id"
    t.index ["validator_id"], name: "index_tickets_on_validator_id"
  end

  create_table "user_accounts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "account_id", null: false
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_user_accounts_on_account_id"
    t.index ["user_id"], name: "index_user_accounts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "name"
    t.string "phone"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "validators", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "event_id", null: false
    t.string "name"
    t.string "email"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_validators_on_account_id"
    t.index ["event_id"], name: "index_validators_on_event_id"
  end

  create_table "venues", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.string "name"
    t.string "address"
    t.string "city"
    t.string "country"
    t.string "latitude"
    t.string "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_venues_on_event_id", unique: true
  end

  add_foreign_key "account_settings", "accounts"
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "events", "accounts"
  add_foreign_key "order_items", "accounts"
  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "ticket_types"
  add_foreign_key "orders", "accounts"
  add_foreign_key "orders", "events"
  add_foreign_key "orders", "validators", column: "validated_by_id"
  add_foreign_key "payments", "orders"
  add_foreign_key "ticket_type_validators", "ticket_types"
  add_foreign_key "ticket_type_validators", "validators"
  add_foreign_key "ticket_types", "events"
  add_foreign_key "tickets", "accounts"
  add_foreign_key "tickets", "events"
  add_foreign_key "tickets", "orders"
  add_foreign_key "tickets", "ticket_types"
  add_foreign_key "tickets", "validators"
  add_foreign_key "user_accounts", "accounts"
  add_foreign_key "user_accounts", "users"
  add_foreign_key "validators", "accounts"
  add_foreign_key "validators", "events"
  add_foreign_key "venues", "events"
end
