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

ActiveRecord::Schema.define(version: 20140718003544) do

  create_table "authentications", force: true do |t|
    t.string   "uid"
    t.string   "provider"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authentications", ["uid", "provider"], name: "index_authentications_on_uid_and_provider"
  add_index "authentications", ["user_id"], name: "index_authentications_on_user_id"

  create_table "dojos", force: true do |t|
    t.datetime "day"
    t.string   "local"
    t.text     "info"
    t.text     "gmaps_link"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "private",    default: false
  end

  create_table "participants", force: true do |t|
    t.integer  "user_id"
    t.integer  "dojo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "participants", ["dojo_id"], name: "index_participants_on_dojo_id"
  add_index "participants", ["user_id"], name: "index_participants_on_user_id"

  create_table "retrospectives", force: true do |t|
    t.string   "challenge"
    t.text     "positive_points"
    t.text     "improvement_points"
    t.integer  "dojo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "retrospectives", ["dojo_id"], name: "index_retrospectives_on_dojo_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
