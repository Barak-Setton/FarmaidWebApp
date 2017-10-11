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

ActiveRecord::Schema.define(version: 20170829104106) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "audios", force: :cascade do |t|
    t.string "name", limit: 256, null: false
    t.integer "audio_order", null: false
    t.string "description", limit: 3000, null: false
    t.integer "tutorial_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "crops", force: :cascade do |t|
    t.string "name", limit: 32, null: false
    t.string "description", limit: 3000, null: false
    t.string "image", limit: 256, null: false
    t.integer "institute_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "images", force: :cascade do |t|
    t.string "name", limit: 256, null: false
    t.integer "image_order", null: false
    t.string "description", limit: 3000, null: false
    t.integer "tutorial_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "institutes", force: :cascade do |t|
    t.string "institute_name", limit: 32, null: false
    t.integer "teacher_admin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.string "message", limit: 5000, null: false
    t.integer "student_id", null: false
    t.integer "teacher_id", null: false
    t.boolean "responded", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "responses", force: :cascade do |t|
    t.string "response", limit: 5000, null: false
    t.integer "teacher_id", null: false
    t.integer "student_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", force: :cascade do |t|
    t.string "name", limit: 32, null: false
    t.string "password", limit: 32, null: false
    t.string "email", limit: 32, null: false
    t.string "phone_number", limit: 32, null: false
    t.string "profile_picture", limit: 128, null: false
    t.integer "institute_id", null: false
    t.datetime "last_file_update"
    t.datetime "last_message_update"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teachers", force: :cascade do |t|
    t.string "name", limit: 32, null: false
    t.string "password", limit: 32, null: false
    t.string "email", limit: 32, null: false
    t.string "phone_number", limit: 32, null: false
    t.string "image", limit: 128
    t.integer "institute_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tutorials", force: :cascade do |t|
    t.string "tutorial_type", limit: 32, null: false
    t.integer "crop_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
