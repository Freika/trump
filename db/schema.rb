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

ActiveRecord::Schema.define(version: 20151203062156) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "auction_items", force: :cascade do |t|
    t.integer  "character_id"
    t.integer  "item_id"
    t.string   "name",         default: "", null: false
    t.string   "bid",          default: ""
    t.string   "buyout",       default: ""
    t.string   "owner_realm",  default: "", null: false
    t.integer  "quantity",     default: 0
    t.string   "time_left",    default: "", null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "auction_items", ["bid"], name: "index_auction_items_on_bid", using: :btree
  add_index "auction_items", ["buyout"], name: "index_auction_items_on_buyout", using: :btree
  add_index "auction_items", ["character_id"], name: "index_auction_items_on_character_id", using: :btree
  add_index "auction_items", ["item_id"], name: "index_auction_items_on_item_id", using: :btree
  add_index "auction_items", ["quantity"], name: "index_auction_items_on_quantity", using: :btree

  create_table "characters", force: :cascade do |t|
    t.string   "name",       default: "", null: false
    t.string   "realm",      default: "", null: false
    t.integer  "goods",      default: 0
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "characters", ["goods"], name: "index_characters_on_goods", using: :btree

  create_table "crono_jobs", force: :cascade do |t|
    t.string   "job_id",            null: false
    t.text     "log"
    t.datetime "last_performed_at"
    t.boolean  "healthy"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "crono_jobs", ["job_id"], name: "index_crono_jobs_on_job_id", unique: true, using: :btree

  create_table "items", force: :cascade do |t|
    t.integer  "wow_id",                  null: false
    t.string   "name",       default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "items", ["wow_id"], name: "index_items_on_wow_id", using: :btree

  create_table "realms", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "last_modified", default: "", null: false
  end

end
