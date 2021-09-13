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

ActiveRecord::Schema.define(version: 2021_09_13_154158) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "additional_documents", force: :cascade do |t|
    t.string "document"
    t.string "notes"
    t.bigint "user_id", null: false
    t.bigint "part_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["part_id"], name: "index_additional_documents_on_part_id"
    t.index ["user_id"], name: "index_additional_documents_on_user_id"
  end

  create_table "interview_questions", force: :cascade do |t|
    t.string "question"
    t.string "notes"
    t.bigint "part_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["part_id"], name: "index_interview_questions_on_part_id"
    t.index ["user_id"], name: "index_interview_questions_on_user_id"
  end

  create_table "parts", force: :cascade do |t|
    t.string "section_number"
    t.string "final_assessment"
    t.float "score"
    t.bigint "sub_section_id", null: false
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_assessment"
    t.index ["sub_section_id"], name: "index_parts_on_sub_section_id"
    t.index ["user_id"], name: "index_parts_on_user_id"
  end

  create_table "related_parts", force: :cascade do |t|
    t.bigint "pt1_id"
    t.bigint "pt2_id"
    t.bigint "pt3_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["pt1_id"], name: "index_related_parts_on_pt1_id"
    t.index ["pt2_id"], name: "index_related_parts_on_pt2_id"
    t.index ["pt3_id"], name: "index_related_parts_on_pt3_id"
  end

  create_table "reports", force: :cascade do |t|
    t.string "name"
    t.string "company"
    t.integer "status", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "sections", force: :cascade do |t|
    t.string "name"
    t.bigint "report_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["report_id"], name: "index_sections_on_report_id"
  end

  create_table "sub_sections", force: :cascade do |t|
    t.string "section_number"
    t.string "name"
    t.bigint "section_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["section_id"], name: "index_sub_sections_on_section_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "email"
    t.string "uid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "additional_documents", "parts"
  add_foreign_key "additional_documents", "users"
  add_foreign_key "interview_questions", "parts"
  add_foreign_key "interview_questions", "users"
  add_foreign_key "parts", "sub_sections"
  add_foreign_key "parts", "users"
  add_foreign_key "related_parts", "parts", column: "pt1_id"
  add_foreign_key "related_parts", "parts", column: "pt2_id"
  add_foreign_key "related_parts", "parts", column: "pt3_id"
  add_foreign_key "sections", "reports"
  add_foreign_key "sub_sections", "sections"
end
