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

ActiveRecord::Schema.define(version: 20150318190944) do

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
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "employee_type_id"
  end

  add_index "employees", ["email"], name: "index_employees_on_email", unique: true
  add_index "employees", ["employee_type_id"], name: "index_employees_on_employee_type_id"
  add_index "employees", ["reset_password_token"], name: "index_employees_on_reset_password_token", unique: true

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
    t.integer  "place_type_id"
  end

  add_index "places", ["place_type_id"], name: "index_places_on_place_type_id"

  create_table "responsibilities", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "responsibility_id"
    t.integer  "task_domain_id"
  end

  add_index "responsibilities", ["responsibility_id"], name: "index_responsibilities_on_responsibility_id"
  add_index "responsibilities", ["task_domain_id"], name: "index_responsibilities_on_task_domain_id"

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
    t.integer  "task_domain_id"
  end

  add_index "task_types", ["task_domain_id"], name: "index_task_types_on_task_domain_id"

  create_table "tasks", force: true do |t|
    t.datetime "after"
    t.datetime "before"
    t.datetime "checkin_start"
    t.datetime "checkin_finish"
    t.text     "details"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "json"
    t.integer  "place_id"
    t.integer  "employee_id"
    t.integer  "task_type_id"
  end

  add_index "tasks", ["employee_id"], name: "index_tasks_on_employee_id"
  add_index "tasks", ["place_id"], name: "index_tasks_on_place_id"
  add_index "tasks", ["task_type_id"], name: "index_tasks_on_task_type_id"

  create_table "tools", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "task_id"
  end

  add_index "tools", ["task_id"], name: "index_tools_on_task_id"

end
