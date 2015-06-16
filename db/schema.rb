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

ActiveRecord::Schema.define(version: 20150616150216) do

  create_table "assignments", force: :cascade do |t|
    t.integer "questionnaire_id",    limit: 4
    t.string  "name",                limit: 255
    t.integer "course_id",           limit: 4
    t.string  "course_name",         limit: 255
    t.integer "student_num",         limit: 4
    t.integer "reviewer_num",        limit: 4
    t.integer "review_num",          limit: 4
    t.decimal "overall_reliability",             precision: 20, scale: 4
    t.integer "undergraduate",       limit: 4
    t.integer "programming",         limit: 4
  end

  create_table "custom_response_score_records", force: :cascade do |t|
    t.integer "assignment_id",    limit: 4
    t.integer "question_id",      limit: 4
    t.integer "score",            limit: 4
    t.text    "comments",         limit: 65535
    t.integer "response_id",      limit: 4
    t.integer "reviewer_id",      limit: 4
    t.integer "reviewee_team_id", limit: 4
    t.integer "word_count",       limit: 4
  end

  create_table "median_grades", force: :cascade do |t|
    t.integer "team_id",     limit: 4
    t.integer "question_id", limit: 4
    t.float   "median",      limit: 24
  end

  create_table "ordinary_response_score_records", force: :cascade do |t|
    t.integer "assignment_id",    limit: 4
    t.integer "question_id",      limit: 4
    t.integer "score",            limit: 4
    t.text    "comments",         limit: 65535
    t.integer "response_id",      limit: 4
    t.integer "reviewer_id",      limit: 4
    t.integer "reviewee_team_id", limit: 4
    t.integer "word_count",       limit: 4
  end

  create_table "question_qualities", force: :cascade do |t|
    t.integer "question_id",                       limit: 4
    t.integer "assignment_id",                     limit: 4
    t.decimal "average_word_count",                           precision: 20, scale: 4
    t.integer "liberal_agreement_num",             limit: 4
    t.integer "conservative_agreement_num",        limit: 4
    t.integer "rated_times",                       limit: 4
    t.float   "liberal_agreement_percentage",      limit: 24
    t.float   "conservative_agreement_percentage", limit: 24
  end

  create_table "question_qualities_by_teams", force: :cascade do |t|
    t.integer "assignment_id",                     limit: 4
    t.integer "question_id",                       limit: 4
    t.integer "team_id",                           limit: 4
    t.integer "liberal_agreement_num",             limit: 4
    t.integer "conservative_agreement_num",        limit: 4
    t.integer "rated_times",                       limit: 4
    t.float   "liberal_agreement_percentage",      limit: 24
    t.float   "conservative_agreement_percentage", limit: 24
  end

  create_table "questionnaire_quality", force: :cascade do |t|
    t.integer "questionnaire_id", limit: 4
    t.integer "assignment_id",    limit: 4
    t.float   "avg_pearson",      limit: 24
    t.float   "avg_spearman",     limit: 24
  end

  create_table "questionnaires", force: :cascade do |t|
    t.string "name", limit: 255
    t.string "type", limit: 255
  end

  create_table "questions", force: :cascade do |t|
    t.text    "txt",              limit: 65535
    t.integer "questionnaire_id", limit: 4
    t.integer "word_count",       limit: 4
    t.integer "tf",               limit: 4
    t.integer "single_complete",  limit: 4
    t.integer "spot_check",       limit: 4
  end

  create_table "response_score_records", force: :cascade do |t|
    t.integer "assignment_id",    limit: 4
    t.integer "question_id",      limit: 4
    t.integer "score",            limit: 4
    t.text    "comments",         limit: 65535
    t.integer "response_id",      limit: 4
    t.integer "reviewer_id",      limit: 4
    t.integer "reviewee_team_id", limit: 4
    t.integer "word_count",       limit: 4
  end

  create_table "responses", force: :cascade do |t|
    t.integer "word_count", limit: 4
  end

  create_table "reviewee_teams", force: :cascade do |t|
    t.integer "assignment_id",       limit: 4
    t.decimal "overall_reliability",           precision: 20, scale: 4
  end

end
