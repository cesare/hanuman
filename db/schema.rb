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

ActiveRecord::Schema.define(version: 20150111141617) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "conferences", force: :cascade do |t|
    t.string   "name",                              null: false
    t.text     "description",                       null: false
    t.boolean  "published",         default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "begins_at",                         null: false
    t.datetime "ends_at",                           null: false
    t.datetime "proposal_deadline",                 null: false
    t.integer  "state",             default: 0,     null: false
  end

  create_table "people", force: :cascade do |t|
    t.string   "name",                       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",      default: false, null: false
    t.string   "email",                      null: false
  end

  create_table "proposals", force: :cascade do |t|
    t.integer  "conference_id", null: false
    t.integer  "person_id",     null: false
    t.string   "title",         null: false
    t.text     "summary",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "notes"
  end

  create_table "staffs", force: :cascade do |t|
    t.integer  "conference_id", null: false
    t.integer  "person_id",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.integer  "person_id",  null: false
    t.string   "name",       null: false
    t.string   "uid",        null: false
    t.string   "provider",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "votes", force: :cascade do |t|
    t.integer  "proposal_id", null: false
    t.integer  "person_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
