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

ActiveRecord::Schema.define(version: 20160824220935) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "members", force: :cascade do |t|
    t.integer  "org_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "members", ["org_id"], name: "index_members_on_org_id", using: :btree
  add_index "members", ["user_id"], name: "index_members_on_user_id", using: :btree

  create_table "orgs", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "owner_id"
  end

  add_index "orgs", ["owner_id"], name: "index_orgs_on_owner_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name_first"
    t.string   "name_last"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "members", "orgs"
  add_foreign_key "members", "users"
  add_foreign_key "orgs", "users", column: "owner_id"
end
