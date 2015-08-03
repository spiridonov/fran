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

ActiveRecord::Schema.define(version: 20150803064842) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "boxes", force: :cascade do |t|
    t.string "name"
    t.string "address"
  end

  create_table "memberships", force: :cascade do |t|
    t.integer "user_id"
  end

  create_table "user_workouts", force: :cascade do |t|
    t.integer "user_id"
    t.integer "workout_id"
    t.boolean "visited",    default: true, null: false
  end

  add_index "user_workouts", ["workout_id", "user_id"], name: "index_user_workouts_on_workout_id_and_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "last_name"
    t.string   "first_name"
    t.string   "vk_token",                          null: false
    t.string   "vk_id",                             null: false
    t.string   "persistence_token",                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",             default: false, null: false
  end

  add_index "users", ["vk_id"], name: "index_users_on_vk_id", using: :btree

  create_table "workouts", force: :cascade do |t|
    t.integer  "box_id"
    t.datetime "datetime"
    t.text     "program"
    t.string   "description"
    t.string   "board_photo"
  end

end
