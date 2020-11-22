# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_19_134534) do

  create_table "admins", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "remember_digest"
  end

  create_table "answer_images", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "image"
    t.bigint "answer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["answer_id"], name: "index_answer_images_on_answer_id"
  end

  create_table "answers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "text"
    t.bigint "question_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["user_id"], name: "index_answers_on_user_id"
  end

  create_table "comments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "text"
    t.string "image"
    t.bigint "teacher_id"
    t.bigint "answer_id"
    t.integer "evaluation", default: 10, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["answer_id"], name: "index_comments_on_answer_id"
    t.index ["teacher_id"], name: "index_comments_on_teacher_id"
  end

  create_table "join_requests", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "school_building_id", null: false
    t.bigint "school_id", null: false
    t.integer "status", default: 10, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["school_building_id"], name: "index_join_requests_on_school_building_id"
    t.index ["school_id"], name: "index_join_requests_on_school_id"
    t.index ["user_id"], name: "index_join_requests_on_user_id"
  end

  create_table "lesson_group_requests", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "lesson_group_id", null: false
    t.bigint "school_building_id", null: false
    t.integer "status", default: 10, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["lesson_group_id"], name: "index_lesson_group_requests_on_lesson_group_id"
    t.index ["school_building_id"], name: "index_lesson_group_requests_on_school_building_id"
    t.index ["user_id"], name: "index_lesson_group_requests_on_user_id"
  end

  create_table "lesson_group_users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "lesson_group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lesson_group_id"], name: "index_lesson_group_users_on_lesson_group_id"
    t.index ["user_id"], name: "index_lesson_group_users_on_user_id"
  end

  create_table "lesson_groups", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "school_building_id"
    t.integer "school_year"
    t.integer "min_school_grade", default: 20, null: false
    t.integer "max_school_grade"
    t.boolean "free_attend", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_building_id"], name: "index_lesson_groups_on_school_building_id"
  end

  create_table "lessons", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "school_id"
    t.bigint "teacher_id"
    t.integer "lesson_group_id"
    t.index ["school_id"], name: "index_lessons_on_school_id"
    t.index ["teacher_id"], name: "index_lessons_on_teacher_id"
  end

  create_table "question_statuses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "question_id"
    t.integer "status", default: 10, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_question_statuses_on_question_id"
    t.index ["user_id"], name: "index_question_statuses_on_user_id"
  end

  create_table "questions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "text"
    t.string "image"
    t.bigint "lesson_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "display_order", default: 1, null: false
    t.boolean "publish", default: false, null: false
    t.index ["lesson_id"], name: "index_questions_on_lesson_id"
  end

  create_table "school_building_teachers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "school_building_id"
    t.bigint "teacher_id"
    t.boolean "main", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_building_id"], name: "index_school_building_teachers_on_school_building_id"
    t.index ["teacher_id"], name: "index_school_building_teachers_on_teacher_id"
  end

  create_table "school_building_users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "school_building_id"
    t.bigint "user_id"
    t.boolean "main", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_building_id"], name: "index_school_building_users_on_school_building_id"
    t.index ["user_id"], name: "index_school_building_users_on_user_id"
  end

  create_table "school_buildings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "school_id"
    t.string "invitation_code"
    t.boolean "auto_invite", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["invitation_code"], name: "index_school_buildings_on_invitation_code", unique: true
    t.index ["school_id"], name: "index_school_buildings_on_school_id"
  end

  create_table "school_users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "school_id"
    t.bigint "user_id"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "activated_at"
    t.boolean "activated", default: false, null: false
    t.index ["school_id"], name: "index_school_users_on_school_id"
    t.index ["user_id"], name: "index_school_users_on_user_id"
  end

  create_table "schools", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "login_path", default: "", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teachers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "start_at"
    t.datetime "end_at"
    t.boolean "activated", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "remember_digest"
    t.string "activation_digest"
    t.datetime "activated_at"
    t.bigint "school_id"
    t.index ["email"], name: "index_teachers_on_email", unique: true
    t.index ["school_id"], name: "index_teachers_on_school_id"
  end

  create_table "user_authentications", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "provider"
    t.string "uid"
    t.bigint "user_id"
    t.string "authentication_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["provider", "uid"], name: "index_user_authentications_on_provider_and_uid", unique: true
    t.index ["uid"], name: "index_user_authentications_on_uid"
    t.index ["user_id"], name: "index_user_authentications_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", default: "名前なし", null: false
    t.string "name_kana"
    t.string "email", default: ""
    t.date "birth_day"
    t.integer "school_grade", default: 20, null: false
    t.string "image"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "remember_digest"
    t.string "line_state_digest"
    t.string "line_user_id"
    t.index ["email"], name: "index_users_on_email"
    t.index ["line_user_id"], name: "index_users_on_line_user_id"
  end

  add_foreign_key "lessons", "schools"
  add_foreign_key "lessons", "teachers"
  add_foreign_key "teachers", "schools"
end
