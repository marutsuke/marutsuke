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

ActiveRecord::Schema.define(version: 2019_05_09_005306) do

  create_table "answers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "answer", null: false
    t.bigint "small_question_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.index ["small_question_id"], name: "index_answers_on_small_question_id"
  end

  create_table "books", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title", null: false
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "rate"
  end

  create_table "chapters", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "chapter", null: false
    t.bigint "book_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_chapters_on_book_id"
  end

  create_table "questions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "text", null: false
    t.string "image"
    t.bigint "section_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["section_id"], name: "index_questions_on_section_id"
  end

  create_table "sections", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "section", null: false
    t.bigint "chapter_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "correct_count", default: 0
    t.index ["chapter_id"], name: "index_sections_on_chapter_id"
  end

  create_table "small_questions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "text", null: false
    t.string "image"
    t.bigint "question_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "section_id"
    t.bigint "book_id"
    t.integer "correct_count", default: 0
    t.integer "incorrect_count", default: 0
    t.date "last_correct_day"
    t.index ["book_id"], name: "index_small_questions_on_book_id"
    t.index ["question_id"], name: "index_small_questions_on_question_id"
    t.index ["section_id"], name: "index_small_questions_on_section_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", default: "名前なし", null: false
    t.string "login_id", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false, null: false
    t.index ["login_id"], name: "index_users_on_login_id", unique: true
  end

  add_foreign_key "answers", "small_questions"
  add_foreign_key "chapters", "books"
  add_foreign_key "questions", "sections"
  add_foreign_key "sections", "chapters"
  add_foreign_key "small_questions", "books"
  add_foreign_key "small_questions", "questions"
  add_foreign_key "small_questions", "sections"
end
