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

ActiveRecord::Schema.define(version: 20160715084702) do

  create_table "bids", force: :cascade do |t|
    t.integer  "favour_id"
    t.integer  "user_id"
    t.boolean  "accepted"
    t.integer  "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "bids", ["favour_id"], name: "index_bids_on_favour_id"
  add_index "bids", ["user_id"], name: "index_bids_on_user_id"

  create_table "clans", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "clans", ["name"], name: "index_clans_on_name"

  create_table "favour_clan_relationships", force: :cascade do |t|
    t.integer  "favour_id"
    t.integer  "clan_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "favour_clan_relationships", ["clan_id"], name: "index_favour_clan_relationships_on_clan_id"
  add_index "favour_clan_relationships", ["favour_id"], name: "index_favour_clan_relationships_on_favour_id"

  create_table "favours", force: :cascade do |t|
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "user_clan_relationships", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.integer  "clan_id"
  end

  add_index "user_clan_relationships", ["clan_id"], name: "index_user_clan_relationships_on_clan_id"
  add_index "user_clan_relationships", ["user_id"], name: "index_user_clan_relationships_on_user_id"

  create_table "user_favour_relationships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "favour_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_favour_relationships", ["favour_id"], name: "index_user_favour_relationships_on_favour_id"
  add_index "user_favour_relationships", ["user_id"], name: "index_user_favour_relationships_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "username"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["username"], name: "index_users_on_username"

end
