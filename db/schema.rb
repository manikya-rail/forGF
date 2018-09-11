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

ActiveRecord::Schema.define(version: 20180803131334) do

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

  create_table "ads", force: :cascade do |t|
    t.integer  "hole_id"
    t.integer  "slot_num"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "amenities", force: :cascade do |t|
    t.boolean  "restaurants"
    t.boolean  "caddies"
    t.boolean  "carts"
    t.integer  "course_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.boolean  "practice_range"
    t.boolean  "golf_boards"
    t.index ["course_id"], name: "index_amenities_on_course_id", using: :btree
  end

  create_table "course_images", force: :cascade do |t|
    t.integer  "course_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.index ["course_id"], name: "index_course_images_on_course_id", using: :btree
  end

  create_table "course_users", force: :cascade do |t|
    t.integer  "course_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_course_users_on_course_id", using: :btree
    t.index ["user_id"], name: "index_course_users_on_user_id", using: :btree
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
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
    t.datetime "cover_updated_at"
    t.integer  "list_id"
    t.string   "number_of_tees"
    t.string   "architect"
    t.string   "score_card_image_file_name"
    t.string   "score_card_image_content_type"
    t.integer  "score_card_image_file_size"
    t.datetime "score_card_image_updated_at"
    t.string   "video_file_name"
    t.string   "video_content_type"
    t.integer  "video_file_size"
    t.datetime "video_updated_at"
    t.string   "transparent_logo_file_name"
    t.string   "transparent_logo_content_type"
    t.integer  "transparent_logo_file_size"
    t.datetime "transparent_logo_updated_at"
    t.string   "logo_hyperlink"
    t.string   "color_selector"
    t.index ["admin_id"], name: "index_courses_on_admin_id", using: :btree
    t.index ["list_id"], name: "index_courses_on_list_id", using: :btree
    t.index ["network_id"], name: "index_courses_on_network_id", using: :btree
    t.index ["resort_id"], name: "index_courses_on_resort_id", using: :btree
  end

  create_table "hcps", force: :cascade do |t|
    t.integer  "score_card_id"
    t.integer  "hole_id"
    t.integer  "hcp"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "hole_images", force: :cascade do |t|
    t.integer  "hole_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "rank"
    t.index ["hole_id"], name: "index_hole_images_on_hole_id", using: :btree
  end

  create_table "holes", force: :cascade do |t|
    t.string   "par"
    t.string   "yards"
    t.string   "mhcp"
    t.string   "whcp"
    t.integer  "course_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "hole_num"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.text     "description"
    t.string   "map_file_name"
    t.string   "map_content_type"
    t.integer  "map_file_size"
    t.datetime "map_updated_at"
    t.string   "logo_image_file_name"
    t.string   "logo_image_content_type"
    t.integer  "logo_image_file_size"
    t.datetime "logo_image_updated_at"
    t.string   "logo_hyperlink"
    t.index ["course_id"], name: "index_holes_on_course_id", using: :btree
  end

  create_table "lists", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "course_id"
    t.index ["course_id"], name: "index_lists_on_course_id", using: :btree
    t.index ["user_id"], name: "index_lists_on_user_id", using: :btree
  end

  create_table "locations", force: :cascade do |t|
    t.string   "town"
    t.string   "state"
    t.float    "lat"
    t.float    "lng"
    t.integer  "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "resort_id"
    t.index ["course_id"], name: "index_locations_on_course_id", using: :btree
  end

  create_table "networks", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pars", force: :cascade do |t|
    t.integer  "score_card_id"
    t.integer  "hole_id"
    t.integer  "par"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "resorts", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "resort_type"
    t.string   "website"
    t.string   "phone_num"
    t.integer  "network_id"
    t.integer  "courses_count"
  end

  create_table "reviews", force: :cascade do |t|
    t.float    "overall_rating",          default: 3.0
    t.float    "value_rating",            default: 3.0
    t.float    "course_upkeep_rating",    default: 3.0
    t.float    "customer_service_rating", default: 3.0
    t.float    "clubhouse_vibe_rating",   default: 3.0
    t.string   "text"
    t.integer  "course_id"
    t.integer  "user_id"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.index ["course_id"], name: "index_reviews_on_course_id", using: :btree
    t.index ["user_id"], name: "index_reviews_on_user_id", using: :btree
  end

  create_table "score_cards", force: :cascade do |t|
    t.string   "tee_name"
    t.string   "color"
    t.integer  "course_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.float    "rating",     default: 0.0
    t.float    "slope",      default: 0.0
    t.integer  "rank"
    t.index ["course_id"], name: "index_score_cards_on_course_id", using: :btree
  end

  create_table "scorecard_images", force: :cascade do |t|
    t.integer  "course_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.index ["course_id"], name: "index_scorecard_images_on_course_id", using: :btree
  end

  create_table "scores", force: :cascade do |t|
    t.integer  "score"
    t.integer  "user_id"
    t.integer  "hole_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hole_id"], name: "index_scores_on_hole_id", using: :btree
    t.index ["user_id"], name: "index_scores_on_user_id", using: :btree
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
    t.integer  "gender"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.string   "location"
    t.string   "home_courses"
    t.string   "handicap_value"
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
    t.string   "videoable_type"
    t.integer  "videoable_id"
    t.string   "title"
    t.text     "description"
    t.string   "thumbnail_image_file_name"
    t.string   "thumbnail_image_content_type"
    t.integer  "thumbnail_image_file_size"
    t.datetime "thumbnail_image_updated_at"
    t.integer  "rank"
    t.string   "status"
  end

  create_table "yardages", force: :cascade do |t|
    t.integer  "score_card_id"
    t.integer  "hole_id"
    t.integer  "yards"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["hole_id"], name: "index_yardages_on_hole_id", using: :btree
    t.index ["score_card_id"], name: "index_yardages_on_score_card_id", using: :btree
  end

  add_foreign_key "course_images", "courses"
  add_foreign_key "course_users", "courses"
  add_foreign_key "course_users", "users"
  add_foreign_key "courses", "lists"
  add_foreign_key "hole_images", "holes"
  add_foreign_key "lists", "courses"
  add_foreign_key "scorecard_images", "courses"
  add_foreign_key "yardages", "holes"
  add_foreign_key "yardages", "score_cards"
end
