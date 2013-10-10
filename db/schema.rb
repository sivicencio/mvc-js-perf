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

ActiveRecord::Schema.define(version: 20131010153939) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "apps", force: true do |t|
    t.string   "name"
    t.string   "project_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "frameworks", force: true do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "instances", force: true do |t|
    t.integer  "app_id"
    t.integer  "framework_id"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "instances", ["app_id"], name: "index_instances_on_app_id", using: :btree
  add_index "instances", ["framework_id"], name: "index_instances_on_framework_id", using: :btree

  create_table "metric_sets", force: true do |t|
    t.string   "ms_type"
    t.integer  "load_time"
    t.integer  "ttfb"
    t.integer  "start_render"
    t.integer  "fully_loaded"
    t.integer  "speed_index"
    t.integer  "dom_elements"
    t.integer  "run_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "metric_sets", ["run_id"], name: "index_metric_sets_on_run_id", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "runs", force: true do |t|
    t.integer  "instance_id"
    t.integer  "test_id"
    t.string   "url"
    t.string   "url_json"
    t.integer  "run_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "wpt_id"
  end

  add_index "runs", ["instance_id"], name: "index_runs_on_instance_id", using: :btree
  add_index "runs", ["test_id"], name: "index_runs_on_test_id", using: :btree

  create_table "test_settings", force: true do |t|
    t.string   "name"
    t.string   "value"
    t.integer  "test_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "test_settings", ["test_id"], name: "index_test_settings_on_test_id", using: :btree

  create_table "tests", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "total_runs"
    t.text     "script"
    t.integer  "app_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tests", ["app_id"], name: "index_tests_on_app_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

end
