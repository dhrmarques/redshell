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

ActiveRecord::Schema.define(version: 20150311201959) do

  create_table "employee_types", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employees", force: true do |t|
    t.string   "name"
    t.string   "last_name"
    t.string   "cpf"
    t.string   "rg"
    t.date     "birth"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "place_types", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.boolean  "restricted"
    t.boolean  "common"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "places", force: true do |t|
    t.string   "code"
    t.string   "compl"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "responsibilities", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "task_domains", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "task_types", force: true do |t|
    t.string   "title"
    t.string   "week_days"
    t.integer  "each_n_weeks"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tasks", force: true do |t|
    t.datetime "after"
    t.datetime "before"
    t.datetime "checkin_start"
    t.datetime "checkin_finish"
    t.text     "details"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tools", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
