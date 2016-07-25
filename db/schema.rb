# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160527073914) do

  create_table "agreements", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "celebrities", force: :cascade do |t|
    t.integer  "count"
    t.string   "cate"
    t.string   "ce_name"
    t.string   "site_name"
    t.string   "you_nickname"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "consults", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "receives", force: :cascade do |t|
    t.integer  "cele_id"
    t.integer  "user_id"
    t.integer  "point"
    t.string   "cate"
    t.string   "reason"
    t.string   "category"
    t.string   "location"
    t.string   "you_nickname"
    t.text     "content"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "sueforms", force: :cascade do |t|
    t.boolean  "evidence"
    t.string   "law_kind"
    t.boolean  "sue_sort"
    t.string   "location"
    t.string   "account_number"
    t.string   "birth_year"
    t.string   "birth_month"
    t.string   "birth_day"
    t.text     "sig_src"
    t.string   "police_name"
    t.integer  "user_id"
    t.string   "my_phone"
    t.string   "my_name"
    t.string   "my_game_name"
    t.string   "address1"
    t.string   "address2"
    t.string   "post_code"
    t.string   "you_id"
    t.string   "you_phone"
    t.string   "you_address"
    t.string   "you_address1"
    t.string   "you_address2"
    t.string   "you_url"
    t.text     "sue_reason"
    t.text     "sue_content"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "sueimgs", force: :cascade do |t|
    t.integer  "sueform_id"
    t.string   "sueimg"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "suggests", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "category"
    t.string   "you_nickname"
    t.string   "you_email"
    t.string   "title"
    t.string   "content"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "users", force: :cascade do |t|
    t.integer  "check"
    t.string   "level"
    t.string   "nickname"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.string   "provider"
    t.string   "uid"
    t.string   "image"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
