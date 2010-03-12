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

ActiveRecord::Schema.define(:version => 20100312191429) do

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

  create_table "costs", :force => true do |t|
    t.string "name"
    t.string "value"
    t.string "description"
  end

  create_table "equipment", :force => true do |t|
    t.string   "unit"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "rate"
  end

  create_table "equipment_jobs", :id => false, :force => true do |t|
    t.integer  "equipment_id"
    t.integer  "job_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gun_marking_categories", :force => true do |t|
    t.string  "name"
    t.integer "position"
  end

  create_table "gun_markings", :force => true do |t|
    t.integer  "gun_sheet_id"
    t.integer  "gun_marking_category_id"
    t.integer  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gun_sheets", :force => true do |t|
    t.integer  "client_id"
    t.integer  "job_id"
    t.integer  "location_id"
    t.boolean  "is_new_construction"
    t.string   "control_section"
    t.date     "date"
    t.time     "started_at"
    t.time     "completed_at"
    t.integer  "sides"
    t.integer  "interchanges"
    t.string   "note"
    t.decimal  "solid_y1"
    t.decimal  "solid_y2"
    t.decimal  "solid_y3"
    t.decimal  "solid_w4"
    t.decimal  "solid_w5"
    t.decimal  "solid_w6"
    t.decimal  "solid_w7"
    t.decimal  "skip_y1"
    t.decimal  "skip_y2"
    t.decimal  "skip_y3"
    t.decimal  "skip_w4"
    t.decimal  "skip_w5"
    t.decimal  "skip_w6"
    t.decimal  "skip_w7"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "job_locations", :force => true do |t|
    t.integer  "job_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "job_markings", :force => true do |t|
    t.integer  "job_id"
    t.integer  "gun_marking_category_id"
    t.integer  "amount"
    t.integer  "rate"
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
    t.string   "name"
    t.text     "notes"
    t.string   "location_name"
  end

  create_table "jobs_users", :id => false, :force => true do |t|
    t.integer  "job_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "load_entries", :force => true do |t|
    t.integer  "load_sheet_id"
    t.integer  "material_id"
    t.decimal  "tote_number"
    t.decimal  "tote_quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "load_sheets", :force => true do |t|
    t.integer  "equipment_id"
    t.integer  "location_id"
    t.integer  "job_id"
    t.integer  "yellow_dip_start"
    t.integer  "yellow_dip_end"
    t.integer  "white_dip_start"
    t.integer  "white_dip_end"
    t.date     "date"
    t.string   "note"
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
    t.integer  "updated_by"
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
    t.integer  "updated_by"
    t.integer  "lunch"
    t.boolean  "per_diem"
    t.integer  "per_diem_rate"
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
    t.integer  "updated_by"
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
    t.integer  "rate"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["last_request_at"], :name => "index_users_on_last_request_at"
  add_index "users", ["login"], :name => "index_users_on_login"
  add_index "users", ["perishable_token"], :name => "index_users_on_perishable_token"
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token"

end
