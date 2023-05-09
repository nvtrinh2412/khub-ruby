# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_05_08_133147) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chats", force: :cascade do |t|
    t.text "text"
    t.bigint "sender_id"
    t.bigint "presentation_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["presentation_id"], name: "index_chats_on_presentation_id"
    t.index ["sender_id"], name: "index_chats_on_sender_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups_users", id: false, force: :cascade do |t|
    t.bigint "group_id", null: false
    t.bigint "user_id", null: false
    t.index ["group_id", "user_id"], name: "index_groups_users_on_group_id_and_user_id"
    t.index ["user_id", "group_id"], name: "index_groups_users_on_user_id_and_group_id"
  end

  create_table "memberships", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "group_id", null: false
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_memberships_on_group_id"
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "presentations", force: :cascade do |t|
    t.string "name"
    t.bigint "creator_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_presentations_on_creator_id"
  end

  create_table "questions", force: :cascade do |t|
    t.text "text"
    t.boolean "is_answered", default: false
    t.integer "voted", default: 0
    t.bigint "presentation_id", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["presentation_id"], name: "index_questions_on_presentation_id"
    t.index ["user_id"], name: "index_questions_on_user_id"
  end

  create_table "slides", force: :cascade do |t|
    t.string "question"
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "presentation_id", null: false
    t.string "sort"
    t.string "heading"
    t.string "sub_heading"
    t.string "description"
    t.index ["presentation_id"], name: "index_slides_on_presentation_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
  end

  create_table "vote_options", force: :cascade do |t|
    t.string "text"
    t.integer "count", default: 0
    t.bigint "slide_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slide_id"], name: "index_vote_options_on_slide_id"
  end

  add_foreign_key "chats", "presentations"
  add_foreign_key "chats", "users", column: "sender_id"
  add_foreign_key "memberships", "groups"
  add_foreign_key "memberships", "users"
  add_foreign_key "presentations", "users", column: "creator_id"
  add_foreign_key "questions", "presentations"
  add_foreign_key "questions", "users"
  add_foreign_key "slides", "presentations"
  add_foreign_key "vote_options", "slides"
end
