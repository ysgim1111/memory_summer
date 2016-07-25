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

ActiveRecord::Schema.define(version: 20151123121608) do

  create_table "hws", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "writer",     limit: 255
    t.string   "title",      limit: 255
    t.text     "content",    limit: 65535
    t.string   "my_image",   limit: 255
    t.string   "secret",     limit: 255
    t.string   "category",   limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "hwscomments", force: :cascade do |t|
    t.integer  "hw_id",      limit: 4
    t.integer  "user_id",    limit: 4
    t.text     "content",    limit: 65535
    t.string   "writer",     limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "hwscomments", ["hw_id"], name: "index_hwscomments_on_hw_id", using: :btree

  create_table "hwslikes", force: :cascade do |t|
    t.integer  "hw_id",      limit: 4
    t.string   "point",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "hwssubcomments", force: :cascade do |t|
    t.integer  "hwscomment_id", limit: 4
    t.integer  "user_id",       limit: 4
    t.string   "writer",        limit: 255
    t.string   "content",       limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "hwsunlikes", force: :cascade do |t|
    t.integer  "hw_id",      limit: 4
    t.string   "point",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "hwsviews", force: :cascade do |t|
    t.integer  "hw_id",      limit: 4
    t.string   "viewcount",  limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "likecontents", force: :cascade do |t|
    t.integer  "likelogin_id", limit: 4
    t.string   "content",      limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "likelogins", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "date",       limit: 255
    t.string   "detaildate", limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "points", force: :cascade do |t|
    t.integer  "post_id",    limit: 4
    t.string   "user",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "qnacomments", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "qna_id",     limit: 4
    t.string   "content",    limit: 255
    t.string   "lawyername", limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "qnas", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "title",      limit: 255
    t.string   "content",    limit: 255
    t.string   "category",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "qnausercomments", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "qna_id",     limit: 4
    t.string   "content",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "qnaviews", force: :cascade do |t|
    t.integer  "qna_id",     limit: 4
    t.string   "viewcount",  limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "sueforms", force: :cascade do |t|
    t.integer  "delivery",     limit: 4
    t.integer  "law_kind",     limit: 4
    t.integer  "location",     limit: 4
    t.string   "police_name",  limit: 255
    t.integer  "user_id",      limit: 4
    t.string   "my_phone",     limit: 255
    t.integer  "my_regist",    limit: 4
    t.string   "you_id",       limit: 255
    t.string   "you_url",      limit: 255
    t.string   "my_name",      limit: 255
    t.string   "my_game_name", limit: 255
    t.string   "post_code",    limit: 255
    t.string   "address1",     limit: 255
    t.string   "address2",     limit: 255
    t.text     "sue_reason",   limit: 65535
    t.text     "sue_content",  limit: 65535
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "sueimgs", force: :cascade do |t|
    t.integer  "sueform_id", limit: 4
    t.string   "sueimg",     limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "level",                  limit: 255
    t.string   "nickname",               limit: 255
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "name",                   limit: 255
    t.string   "provider",               limit: 255
    t.string   "uid",                    limit: 255
    t.string   "image",                  limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "hwscomments", "hws"
end
