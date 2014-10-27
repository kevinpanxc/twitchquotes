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

ActiveRecord::Schema.define(version: 20141025092734) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "announcements", force: true do |t|
    t.text     "content"
    t.boolean  "expired"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "content_unevaluated"
  end

  create_table "dislikes", force: true do |t|
    t.integer  "quote_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "dislikes", ["quote_id"], name: "index_dislikes_on_quote_id", using: :btree
  add_index "dislikes", ["user_id"], name: "index_dislikes_on_user_id", using: :btree

  create_table "facebook_users", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "likes", force: true do |t|
    t.integer  "quote_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "likes", ["quote_id"], name: "index_likes_on_quote_id", using: :btree
  add_index "likes", ["user_id"], name: "index_likes_on_user_id", using: :btree

  create_table "quotes", force: true do |t|
    t.text     "quote"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "stream_id"
    t.string   "title"
    t.integer  "marked_as"
  end

  create_table "streams", force: true do |t|
    t.string   "name"
    t.string   "stream_id"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "logo"
    t.integer  "followers"
    t.integer  "quotes_count", default: 0
  end

  create_table "users", force: true do |t|
    t.string   "username",        limit: 24
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",                      default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
