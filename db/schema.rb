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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110515175902) do

  create_table "activities", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "limit"
    t.datetime "start"
    t.datetime "end"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bookings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "activity_id"
    t.integer  "guests"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "memberships", :force => true do |t|
    t.string   "title"
    t.string   "description"
    t.boolean  "swimming"
    t.boolean  "tennis"
    t.boolean  "sauna"
    t.integer  "guests"
    t.decimal  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.string   "description"
    t.boolean  "published"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscriptions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "membership_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "forename"
    t.string   "surname"
    t.string   "encrypted_password"
    t.string   "salt"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",              :default => false
  end

end
