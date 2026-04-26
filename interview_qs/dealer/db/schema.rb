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

ActiveRecord::Schema[8.1].define(version: 2026_04_26_103305) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "dealer_profiles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "dealer_name"
    t.decimal "dealer_rating", precision: 3, scale: 1, default: "5.0", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_dealer_profiles_on_user_id"
  end

  create_table "offers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "dealer_profile_id", null: false
    t.integer "price", null: false
    t.bigint "request_id", null: false
    t.datetime "updated_at", null: false
    t.index ["dealer_profile_id", "request_id"], name: "index_offers_on_dealer_profile_id_and_request_id", unique: true
    t.index ["dealer_profile_id"], name: "index_offers_on_dealer_profile_id"
    t.index ["request_id"], name: "index_offers_on_request_id"
  end

  create_table "requests", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "make"
    t.integer "mileage"
    t.string "model"
    t.integer "state", default: 0, null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.integer "year"
    t.index ["state"], name: "index_requests_on_state"
    t.index ["user_id"], name: "index_requests_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "ip_address"
    t.datetime "updated_at", null: false
    t.string "user_agent"
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.integer "account_type", default: 0, null: false
    t.datetime "created_at", null: false
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "updated_at", null: false
    t.index ["account_type"], name: "index_users_on_account_type"
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "dealer_profiles", "users"
  add_foreign_key "offers", "dealer_profiles"
  add_foreign_key "offers", "requests"
  add_foreign_key "requests", "users"
  add_foreign_key "sessions", "users"
end
