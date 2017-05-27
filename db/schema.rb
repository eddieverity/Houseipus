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

ActiveRecord::Schema.define(version: 20170527183401) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "favorites", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "house_rent_id"
    t.bigint "house_sale_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["house_rent_id"], name: "index_favorites_on_house_rent_id"
    t.index ["house_sale_id"], name: "index_favorites_on_house_sale_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "house_rents", force: :cascade do |t|
    t.integer "addr"
    t.string "street"
    t.string "unit"
    t.string "city"
    t.string "state"
    t.integer "zip"
    t.integer "bed"
    t.integer "bath"
    t.integer "sq_ft"
    t.integer "price"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "house_sales", force: :cascade do |t|
    t.integer "addr"
    t.string "street"
    t.string "unit"
    t.string "city"
    t.string "state"
    t.integer "zip"
    t.integer "bed"
    t.integer "bath"
    t.integer "sq_ft"
    t.integer "price"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "imgs", force: :cascade do |t|
    t.string "context"
    t.bigint "house_rent_id"
    t.bigint "house_sale_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["house_rent_id"], name: "index_imgs_on_house_rent_id"
    t.index ["house_sale_id"], name: "index_imgs_on_house_sale_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.bigint "sender_id"
    t.bigint "receiver_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["receiver_id"], name: "index_messages_on_receiver_id"
    t.index ["sender_id"], name: "index_messages_on_sender_id"
  end

  create_table "saved_searches", force: :cascade do |t|
    t.bigint "user_id"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_saved_searches_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "context"
    t.bigint "house_sale_id"
    t.bigint "house_rent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["house_rent_id"], name: "index_tags_on_house_rent_id"
    t.index ["house_sale_id"], name: "index_tags_on_house_sale_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.integer "addr"
    t.string "first_name"
    t.string "last_name"
    t.integer "phone"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "favorites", "house_rents"
  add_foreign_key "favorites", "house_sales"
  add_foreign_key "favorites", "users"
  add_foreign_key "imgs", "house_rents"
  add_foreign_key "imgs", "house_sales"
  add_foreign_key "messages", "users", column: "receiver_id"
  add_foreign_key "messages", "users", column: "sender_id"
  add_foreign_key "saved_searches", "users"
  add_foreign_key "tags", "house_rents"
  add_foreign_key "tags", "house_sales"
end
