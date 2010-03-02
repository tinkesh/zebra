# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100302014703) do

  create_table "careers", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "province"
    t.string   "phone"
    t.string   "email"
    t.boolean  "have_class5"
    t.boolean  "have_class3"
    t.boolean  "have_class1"
    t.boolean  "have_overtime"
    t.boolean  "have_travel"
    t.boolean  "have_firstaid"
    t.boolean  "have_tdg"
    t.boolean  "have_seasonal"
    t.boolean  "have_experience"
    t.text     "references"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clients", :force => true do |t|
    t.string   "name"
    t.string   "contact"
    t.string   "address"
    t.string   "city"
    t.string   "province"
    t.string   "postal_code"
    t.string   "phone"
    t.string   "email"
    t.string   "work_phone"
    t.string   "cell_phone"
    t.string   "fax"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "completions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", :force => true do |t|
    t.string   "name"
    t.string   "company"
    t.string   "address"
    t.string   "city"
    t.string   "province"
    t.string   "phone"
    t.string   "email"
    t.string   "subject"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "equipment", :force => true do |t|
    t.string   "unit"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "equipment_jobs", :id => false, :force => true do |t|
    t.integer  "equipment_id"
    t.integer  "job_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jobs", :force => true do |t|
    t.integer  "completion_id"
    t.integer  "client_id"
    t.date     "started_on"
    t.date     "completed_on"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jobs_locations", :id => false, :force => true do |t|
    t.integer  "job_id"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jobs_users", :id => false, :force => true do |t|
    t.integer  "job_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "manufacturers", :force => true do |t|
    t.string   "name"
    t.string   "abbreviation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "materials", :force => true do |t|
    t.integer  "manufacturer_id"
    t.string   "batch"
    t.string   "category"
    t.integer  "litre_per_tote"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "time_entries", :force => true do |t|
    t.integer  "time_sheet_id"
    t.integer  "user_id"
    t.decimal  "time"
    t.string   "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "created_by"
  end

  create_table "time_note_categories", :force => true do |t|
    t.string  "name"
    t.integer "position"
  end

  create_table "time_sheets", :force => true do |t|
    t.integer  "job_id"
    t.integer  "location_id"
    t.integer  "time_note_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
    t.string   "note"
    t.datetime "started_at"
    t.datetime "completed_at"
  end

  create_table "time_task_categories", :force => true do |t|
    t.string  "name"
    t.integer "position"
  end

  create_table "time_tasks", :force => true do |t|
    t.integer  "time_sheet_id"
    t.integer  "time_task_category_id"
    t.datetime "happened_at"
    t.decimal  "time"
    t.string   "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
  end

  create_table "users", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "login",                             :null => false
    t.string   "crypted_password",                  :null => false
    t.string   "password_salt",                     :null => false
    t.string   "persistence_token",                 :null => false
    t.integer  "login_count",       :default => 0,  :null => false
    t.datetime "last_request_at"
    t.datetime "last_login_at"
    t.datetime "current_login_at"
    t.string   "last_login_ip"
    t.string   "current_login_ip"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "perishable_token",  :default => "", :null => false
    t.string   "email",             :default => "", :null => false
    t.string   "time_zone"
    t.string   "home_phone"
    t.string   "cell_phone"
    t.string   "address"
    t.string   "city"
    t.string   "province"
    t.string   "postal_code"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["last_request_at"], :name => "index_users_on_last_request_at"
  add_index "users", ["login"], :name => "index_users_on_login"
  add_index "users", ["perishable_token"], :name => "index_users_on_perishable_token"
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token"

end
