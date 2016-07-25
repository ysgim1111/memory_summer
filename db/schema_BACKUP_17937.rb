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

ActiveRecord::Schema.define(version: 20151202045318) do

  create_table "hws", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "writer"
    t.string   "title"
    t.text     "content"
    t.string   "my_image"
    t.string   "secret"
    t.string   "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hwscomments", force: :cascade do |t|
    t.integer  "hw_id"
    t.integer  "user_id"
    t.text     "content"
    t.string   "writer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "hwscomments", ["hw_id"], name: "index_hwscomments_on_hw_id"

  create_table "hwslikes", force: :cascade do |t|
    t.integer  "hw_id"
    t.string   "point"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hwssubcomments", force: :cascade do |t|
    t.integer  "hwscomment_id"
    t.integer  "user_id"
    t.string   "writer"
    t.string   "content"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "hwsunlikes", force: :cascade do |t|
    t.integer  "hw_id"
    t.string   "point"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hwsviews", force: :cascade do |t|
    t.integer  "hw_id"
    t.string   "viewcount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "likecontents", force: :cascade do |t|
    t.integer  "likelogin_id"
    t.string   "content"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "likelogins", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "date"
    t.string   "detaildate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
<<<<<<< HEAD
  end

  create_table "points", force: :cascade do |t|
    t.integer  "post_id"
    t.string   "user"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
=======
>>>>>>> 2a89e4eed02ddd7a92f3cc9bc47df52d5ab46a8f
  end

  create_table "qnacomments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "qna_id"
    t.string   "content"
    t.string   "lawyername"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "qnas", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "content"
    t.string   "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

<<<<<<< HEAD
  create_table "qnausercomments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "qna_id"
    t.string   "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
=======
  create_table "qnasubcomments", force: :cascade do |t|
    t.integer  "qnacomment_id"
    t.integer  "user_id"
    t.string   "writer"
    t.string   "content"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
>>>>>>> 2a89e4eed02ddd7a92f3cc9bc47df52d5ab46a8f
  end

  create_table "qnaviews", force: :cascade do |t|
    t.integer  "qna_id"
    t.string   "viewcount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sueforms", force: :cascade do |t|
    t.integer  "delivery"
    t.integer  "law_kind"
    t.integer  "location"
    t.string   "police_name"
    t.integer  "user_id"
    t.string   "my_phone"
    t.integer  "my_regist"
    t.string   "you_id"
    t.string   "you_url"
    t.string   "my_name"
    t.string   "my_game_name"
    t.string   "post_code"
    t.string   "address1"
    t.string   "address2"
    t.text     "sue_reason"
    t.text     "sue_content"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "sueimgs", force: :cascade do |t|
    t.integer  "sueform_id"
    t.string   "sueimg"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
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
