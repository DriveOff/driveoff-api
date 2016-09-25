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

ActiveRecord::Schema.define(version: 20160925020458) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "businesses", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "businesses", ["user_id"], name: "index_businesses_on_user_id", using: :btree

  create_table "redemptions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "reward_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "redemptions", ["reward_id"], name: "index_redemptions_on_reward_id", using: :btree
  add_index "redemptions", ["user_id"], name: "index_redemptions_on_user_id", using: :btree

  create_table "rewards", force: :cascade do |t|
    t.integer  "business_id"
    t.string   "title",       null: false
    t.text     "description"
    t.integer  "cost",        null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "rewards", ["business_id"], name: "index_rewards_on_business_id", using: :btree

  create_table "trips", force: :cascade do |t|
    t.decimal  "distance",   precision: 6, scale: 1, default: 0.0, null: false
    t.integer  "time",                               default: 0,   null: false
    t.integer  "points",                             default: 0,   null: false
    t.integer  "user_id"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
  end

  add_index "trips", ["user_id"], name: "index_trips_on_user_id", using: :btree

  create_table "user_connections", id: false, force: :cascade do |t|
    t.integer "user_1_id", null: false
    t.integer "user_2_id", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                                                  null: false
    t.string   "crypted_password",                                       null: false
    t.string   "salt",                                                   null: false
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.datetime "last_login_at"
    t.datetime "last_logout_at"
    t.datetime "last_activity_at"
    t.string   "last_login_from_ip_address"
    t.string   "name",                                                   null: false
    t.integer  "role",                            default: 1,            null: false
    t.string   "avatar"
    t.string   "city"
    t.string   "state"
    t.integer  "zip_code"
    t.date     "birthday",                        default: '1980-01-01', null: false
    t.integer  "gender",                          default: 1,            null: false
    t.string   "custom_gender"
    t.integer  "pronouns"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["last_logout_at", "last_activity_at"], name: "index_users_on_last_logout_at_and_last_activity_at", using: :btree
  add_index "users", ["remember_me_token"], name: "index_users_on_remember_me_token", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", using: :btree

  add_foreign_key "businesses", "users"
  add_foreign_key "redemptions", "rewards"
  add_foreign_key "redemptions", "users"
  add_foreign_key "rewards", "businesses"
  add_foreign_key "trips", "users"
end
