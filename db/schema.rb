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

ActiveRecord::Schema.define(version: 20170122172101) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_keys", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "authentication_token", null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["authentication_token"], name: "index_api_keys_on_authentication_token", unique: true, using: :btree
    t.index ["user_id"], name: "index_api_keys_on_user_id", using: :btree
  end

  create_table "captions", force: :cascade do |t|
    t.string   "text",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.integer  "game_id"
    t.index ["game_id"], name: "index_captions_on_game_id", using: :btree
    t.index ["user_id"], name: "index_captions_on_user_id", using: :btree
  end

  create_table "games", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groupings", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "game_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_groupings_on_game_id", using: :btree
    t.index ["user_id"], name: "index_groupings_on_user_id", using: :btree
  end

  create_table "snap_caption_pairs", force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "snap_id"
    t.integer  "caption_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["caption_id"], name: "index_snap_caption_pairs_on_caption_id", using: :btree
    t.index ["game_id"], name: "index_snap_caption_pairs_on_game_id", using: :btree
    t.index ["snap_id"], name: "index_snap_caption_pairs_on_snap_id", using: :btree
  end

  create_table "snaps", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "image_src",  null: false
    t.integer  "user_id"
    t.integer  "game_id"
    t.index ["game_id"], name: "index_snaps_on_game_id", using: :btree
    t.index ["user_id"], name: "index_snaps_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "display_name",      null: false
    t.string   "profile_image_url", null: false
    t.string   "fb_access_token",   null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

end
