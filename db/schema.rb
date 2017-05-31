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

ActiveRecord::Schema.define(version: 20170531193409) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "first_name"
    t.string   "last_name"
    t.index ["email"], name: "index_admins_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree
  end

  create_table "amenities", force: :cascade do |t|
    t.boolean  "restaurants"
    t.boolean  "caddies"
    t.boolean  "carts"
    t.integer  "course_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["course_id"], name: "index_amenities_on_course_id", using: :btree
  end

  create_table "courses", force: :cascade do |t|
    t.string   "name"
    t.integer  "course_type"
    t.text     "bio"
    t.string   "website"
    t.string   "phone_num"
    t.integer  "total_par"
    t.float    "slope"
    t.float    "rating"
    t.integer  "length"
    t.integer  "admin_id"
    t.integer  "resort_id"
    t.integer  "network_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
    t.datetime "cover_updated_at"
    t.index ["admin_id"], name: "index_courses_on_admin_id", using: :btree
    t.index ["network_id"], name: "index_courses_on_network_id", using: :btree
    t.index ["resort_id"], name: "index_courses_on_resort_id", using: :btree
  end

  create_table "holes", force: :cascade do |t|
    t.string   "par"
    t.string   "yards"
    t.string   "mhcp"
    t.string   "whcp"
    t.integer  "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "hole_num"
    t.index ["course_id"], name: "index_holes_on_course_id", using: :btree
  end

  create_table "locations", force: :cascade do |t|
    t.string   "town"
    t.string   "state"
    t.float    "lat"
    t.float    "lng"
    t.integer  "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_locations_on_course_id", using: :btree
  end

  create_table "networks", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "resorts", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "score_cards", force: :cascade do |t|
    t.string   "tee_name"
    t.string   "color"
    t.integer  "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_score_cards_on_course_id", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string   "tag"
    t.float    "time"
    t.integer  "video_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                             default: "", null: false
    t.string   "encrypted_password",                default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "authentication_token",   limit: 30
    t.string   "first_name"
    t.string   "last_name"
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "videos", force: :cascade do |t|
    t.string   "video_file_name"
    t.string   "video_content_type"
    t.integer  "video_file_size"
    t.datetime "video_updated_at"
    t.integer  "hole_id"
  end

end
