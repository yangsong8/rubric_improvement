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

ActiveRecord::Schema.define(version: 20150531171005) do

  create_table "assignments", force: :cascade do |t|
    t.integer "questionnaire_id",    limit: 4
    t.string  "name",                limit: 255
    t.integer "course_id",           limit: 4
    t.string  "course_name",         limit: 255
    t.integer "student_num",         limit: 4
    t.integer "reviewer_num",        limit: 4
    t.integer "review_num",          limit: 4
    t.float   "overall_reliability", limit: 24
  end

  create_table "custom_response_score_records", force: :cascade do |t|
    t.integer  "assignment_id",    limit: 4
    t.integer  "question_id",      limit: 4
    t.integer  "score",            limit: 4
    t.text     "comments",         limit: 65535
    t.integer  "response_id",      limit: 4
    t.integer  "reviewer_id",      limit: 4
    t.integer  "reviewee_team_id", limit: 4
    t.integer  "word_count",       limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "ordinary_response_score_records", force: :cascade do |t|
    t.integer  "assignment_id",    limit: 4
    t.integer  "question_id",      limit: 4
    t.integer  "score",            limit: 4
    t.text     "comments",         limit: 65535
    t.integer  "response_id",      limit: 4
    t.integer  "reviewer_id",      limit: 4
    t.integer  "reviewee_team_id", limit: 4
    t.integer  "word_count",       limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "question_quality", force: :cascade do |t|
    t.integer "question_id",         limit: 4
    t.integer "assignment_id",       limit: 4
    t.float   "overall_reliability", limit: 24
  end

  create_table "questions", force: :cascade do |t|
    t.text    "txt",              limit: 65535
    t.integer "questionnaire_id", limit: 4
  end

  create_table "reviewee_teams", force: :cascade do |t|
    t.integer "assignment_id",       limit: 4
    t.float   "overall_reliability", limit: 24
  end

end
