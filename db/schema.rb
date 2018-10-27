# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_10_27_031812) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: :cascade do |t|
    t.string "uid"
    t.string "token"
    t.string "provider"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_authentications_on_user_id"
  end

  create_table "cryptos", force: :cascade do |t|
    t.string "symbol"
    t.integer "user_id"
    t.decimal "cost_per"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "amount_owned"
    t.decimal "last_transaction"
    t.string "last_action"
    t.index ["user_id"], name: "index_cryptos_on_user_id"
  end

  create_table "searches", force: :cascade do |t|
    t.string "keywords"
    t.string "id_crypto"
    t.string "name"
    t.string "symbol"
    t.string "rank"
    t.string "market"
    t.string "category"
    t.decimal "min_price"
    t.decimal "max_price"
    t.decimal "volume_24h_usd"
    t.string "percent_change_1h"
    t.string "percent_change_24h"
    t.string "percent_change_7d"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "gender"
    t.string "phone"
    t.string "country"
    t.datetime "birthdate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "firstname"
    t.string "lastname"
    t.boolean "verification"
    t.string "role", default: "user"
    t.string "avatar"
    t.index ["email"], name: "index_users_on_email"
  end

  add_foreign_key "authentications", "users"
end
