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

ActiveRecord::Schema.define(version: 20141112003507) do

  create_table "favorites", force: true do |t|
    t.integer  "user_id"
    t.integer  "tweet_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "selection"
  end

  add_index "favorites", ["tweet_id"], name: "index_favorites_on_tweet_id"
  add_index "favorites", ["user_id", "created_at"], name: "index_favorites_on_user_id_and_created_at"
  add_index "favorites", ["user_id"], name: "index_favorites_on_user_id"

  create_table "locations", force: true do |t|
    t.string   "latitude"
    t.string   "longitude"
    t.string   "name"
    t.integer  "radius"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "plans", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.decimal  "amount",                       precision: 6, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "stripe_plan_id"
    t.boolean  "public"
    t.boolean  "automatic_favoriting_enabled"
    t.integer  "max_search_terms"
    t.integer  "max_favorites_per_day"
  end

  create_table "search_terms", force: true do |t|
    t.string   "keywords"
    t.string   "string"
    t.integer  "location_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tweets", force: true do |t|
    t.integer  "user_id"
    t.integer  "search_term_id"
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tweet_id"
  end

  add_index "tweets", ["search_term_id"], name: "index_tweets_on_search_term_id"
  add_index "tweets", ["user_id", "created_at"], name: "index_tweets_on_user_id_and_created_at"
  add_index "tweets", ["user_id"], name: "index_tweets_on_user_id"

  create_table "user_plans", force: true do |t|
    t.integer  "user_id"
    t.integer  "plan_id"
    t.string   "stripe_subscription_id"
    t.string   "stripe_customer_id"
    t.datetime "expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_plans", ["plan_id"], name: "index_user_plans_on_plan_id"
  add_index "user_plans", ["user_id"], name: "index_user_plans_on_user_id"

  create_table "users", force: true do |t|
    t.string   "email",                       default: ""
    t.string   "encrypted_password",          default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",               default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
    t.boolean  "admin",                       default: false
    t.string   "username"
    t.string   "twitter_access_token"
    t.string   "twitter_access_token_secret"
    t.boolean  "automatic_favoriting",        default: true
    t.boolean  "weekly_updates",              default: true
    t.string   "unsubscribe_token"
  end

  add_index "users", ["email"], name: "index_users_on_email"
  add_index "users", ["provider"], name: "index_users_on_provider"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["uid"], name: "index_users_on_uid"

end
