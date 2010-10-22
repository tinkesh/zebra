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

ActiveRecord::Schema.define(:version => 20101021194409) do

  create_table "careers", :force => true do |t|
    t.string    "name"
    t.string    "address"
    t.string    "city"
    t.string    "province"
    t.string    "phone"
    t.string    "email"
    t.boolean   "have_class5"
    t.boolean   "have_class3"
    t.boolean   "have_class1"
    t.boolean   "have_overtime"
    t.boolean   "have_travel"
    t.boolean   "have_firstaid"
    t.boolean   "have_tdg"
    t.boolean   "have_seasonal"
    t.boolean   "have_experience"
    t.text      "references"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "clients", :force => true do |t|
    t.string    "name"
    t.string    "contact"
    t.string    "address"
    t.string    "city"
    t.string    "province"
    t.string    "postal_code"
    t.string    "phone"
    t.string    "email"
    t.string    "work_phone"
    t.string    "cell_phone"
    t.string    "fax"
    t.text      "notes"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "completions", :force => true do |t|
    t.string    "name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "contacts", :force => true do |t|
    t.string    "name"
    t.string    "company"
    t.string    "address"
    t.string    "city"
    t.string    "province"
    t.string    "phone"
    t.string    "email"
    t.string    "subject"
    t.text      "body"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "costs", :force => true do |t|
    t.string "name"
    t.string "value"
    t.string "description"
  end

  create_table "crews", :force => true do |t|
    t.string    "name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "crews_jobs", :id => false, :force => true do |t|
    t.integer "crew_id"
    t.integer "job_id"
  end

  create_table "equipment", :force => true do |t|
    t.string    "unit"
    t.string    "name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "rate"
    t.integer   "yellow_rate"
    t.integer   "white_rate"
  end

  create_table "equipment_jobs", :id => false, :force => true do |t|
    t.integer   "equipment_id"
    t.integer   "job_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "estimates", :force => true do |t|
    t.integer   "job_id"
    t.integer   "time_sheet_id"
    t.decimal   "hours"
    t.integer   "crew_size"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "gun_marking_categories", :force => true do |t|
    t.string  "name"
    t.integer "position"
  end

  create_table "gun_markings", :force => true do |t|
    t.integer   "gun_sheet_id"
    t.integer   "gun_marking_category_id"
    t.decimal   "amount"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "gun_markings", ["gun_sheet_id"], :name => "index_gun_markings_on_gun_sheet_id"

  create_table "gun_sheets", :force => true do |t|
    t.integer   "client_id"
    t.integer   "job_id"
    t.boolean   "is_new_construction"
    t.string    "control_section"
    t.date      "started_on"
    t.time      "started_at"
    t.time      "completed_at"
    t.integer   "sides"
    t.integer   "interchanges"
    t.string    "note"
    t.decimal   "solid_y1"
    t.decimal   "solid_y2"
    t.decimal   "solid_y3"
    t.decimal   "solid_w4"
    t.decimal   "solid_w5"
    t.decimal   "solid_w6"
    t.decimal   "solid_w7"
    t.decimal   "skip_y1"
    t.decimal   "skip_y2"
    t.decimal   "skip_y3"
    t.decimal   "skip_w4"
    t.decimal   "skip_w5"
    t.decimal   "skip_w6"
    t.decimal   "skip_w7"
    t.integer   "created_by"
    t.integer   "updated_by"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "location_name"
    t.integer   "job_location_id"
    t.timestamp "versioned_at"
    t.date      "completed_on"
    t.integer   "equipment_id"
  end

  add_index "gun_sheets", ["job_id"], :name => "index_gun_sheets_on_job_id"

  create_table "gun_sheets_job_sheets", :id => false, :force => true do |t|
    t.integer "gun_sheet_id"
    t.integer "job_sheet_id"
  end

  create_table "job_locations", :force => true do |t|
    t.integer   "job_id"
    t.string    "name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "job_markings", :force => true do |t|
    t.integer   "job_id"
    t.integer   "gun_marking_category_id"
    t.decimal   "amount"
    t.integer   "rate"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "job_markings", ["gun_marking_category_id"], :name => "index_job_markings_on_gun_marking_category_id"
  add_index "job_markings", ["job_id"], :name => "index_job_markings_on_job_id"

  create_table "job_sheets", :force => true do |t|
    t.date      "date"
    t.integer   "job_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.decimal   "material_rate"
    t.integer   "created_by"
  end

  add_index "job_sheets", ["job_id"], :name => "index_job_sheets_on_job_id"

  create_table "job_sheets_time_sheets", :id => false, :force => true do |t|
    t.integer "job_sheet_id"
    t.integer "time_sheet_id"
  end

  create_table "jobs", :force => true do |t|
    t.integer   "completion_id"
    t.integer   "client_id"
    t.date      "started_on"
    t.date      "completed_on"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "name"
    t.text      "notes"
    t.string    "location_name"
    t.string    "versioned_user_ids"
    t.string    "versioned_equipment_ids"
    t.timestamp "versioned_at"
    t.boolean   "is_archived",             :default => false
  end

  create_table "jobs_locations", :id => false, :force => true do |t|
    t.integer   "job_id"
    t.integer   "location_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "jobs_time_entries", :force => true do |t|
    t.integer   "job_id"
    t.integer   "time_entry_id"
    t.decimal   "hours"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "jobs_time_sheets", :force => true do |t|
    t.integer "job_id"
    t.integer "time_sheet_id"
  end

  create_table "load_entries", :force => true do |t|
    t.integer   "load_sheet_id"
    t.integer   "material_id"
    t.decimal   "tote_number"
    t.decimal   "tote_quantity"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "category"
  end

  add_index "load_entries", ["load_sheet_id"], :name => "index_load_entries_on_load_sheet_id"

  create_table "load_sheets", :force => true do |t|
    t.integer   "equipment_id"
    t.integer   "location_id"
    t.integer   "job_id"
    t.integer   "yellow_dip_start"
    t.integer   "yellow_dip_end"
    t.integer   "white_dip_start"
    t.integer   "white_dip_end"
    t.date      "date"
    t.string    "note"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "location_name"
    t.timestamp "versioned_at"
    t.integer   "created_by"
    t.integer   "adjusted_yellow_dip_start", :default => 0
    t.integer   "adjusted_yellow_dip_stop",  :default => 0
    t.integer   "adjusted_white_dip_start",  :default => 0
    t.integer   "adjusted_white_dip_stop",   :default => 0
  end

  add_index "load_sheets", ["job_id"], :name => "index_load_sheets_on_job_id"

  create_table "locations", :force => true do |t|
    t.string    "name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "manufacturers", :force => true do |t|
    t.string    "name"
    t.string    "abbreviation"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "amount"
  end

  create_table "material_reports", :force => true do |t|
    t.integer   "job_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "created_by"
    t.integer   "gun_sheet_id"
    t.integer   "load_sheet_id"
  end

  create_table "materials", :force => true do |t|
    t.integer   "manufacturer_id"
    t.string    "batch"
    t.string    "category"
    t.integer   "litre_per_tote"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string    "name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "sessions", :force => true do |t|
    t.string    "session_id", :null => false
    t.text      "data"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "time_entries", :force => true do |t|
    t.integer   "user_id"
    t.integer   "time_sheet_id"
    t.date      "date"
    t.timestamp "clock_in"
    t.timestamp "clock_out"
    t.string    "note"
    t.decimal   "rate"
    t.timestamp "clocked_in_at"
    t.timestamp "clocked_out_at"
    t.integer   "clocked_in_by"
    t.integer   "clocked_out_by"
    t.boolean   "active"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.boolean   "bank_overtime_hours"
  end

  add_index "time_entries", ["clock_in"], :name => "index_time_entries_on_clock_in"
  add_index "time_entries", ["user_id"], :name => "index_time_entries_on_user_id"

  create_table "time_note_categories", :force => true do |t|
    t.string  "name"
    t.integer "position"
  end

  create_table "time_sheets", :force => true do |t|
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
    t.integer  "per_diem_rate"
    t.decimal  "fuel"
    t.decimal  "hotel"
    t.decimal  "fuel_rate"
    t.datetime "versioned_at"
    t.string   "versioned_time_entry_ids"
    t.decimal  "per_diem_percent",         :default => 0.0
  end

  create_table "time_task_categories", :force => true do |t|
    t.string  "name"
    t.integer "position"
  end

  create_table "time_tasks", :force => true do |t|
    t.integer   "time_sheet_id"
    t.integer   "time_task_category_id"
    t.timestamp "happened_at"
    t.decimal   "time"
    t.string    "note"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "created_by"
    t.integer   "updated_by"
  end

  create_table "users", :force => true do |t|
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "login",                                         :null => false
    t.string    "crypted_password",                              :null => false
    t.string    "password_salt",                                 :null => false
    t.string    "persistence_token",                             :null => false
    t.integer   "login_count",           :default => 0,          :null => false
    t.timestamp "last_request_at"
    t.timestamp "last_login_at"
    t.timestamp "current_login_at"
    t.string    "last_login_ip"
    t.string    "current_login_ip"
    t.string    "first_name"
    t.string    "last_name"
    t.string    "perishable_token",      :default => "",         :null => false
    t.string    "email",                 :default => "",         :null => false
    t.string    "time_zone"
    t.string    "home_phone"
    t.string    "cell_phone"
    t.string    "address"
    t.string    "city"
    t.string    "province"
    t.string    "postal_code"
    t.integer   "rate"
    t.boolean   "bank_overtime_hours"
    t.string    "versioned_role_ids"
    t.timestamp "versioned_at"
    t.integer   "crew_id"
    t.string    "employment_state",      :default => "Employed"
    t.text      "employment_start_date"
    t.text      "employment_end_date"
    t.string    "employment_notes"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["last_request_at"], :name => "index_users_on_last_request_at"
  add_index "users", ["login"], :name => "index_users_on_login"
  add_index "users", ["perishable_token"], :name => "index_users_on_perishable_token"
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token"

  create_table "versions", :force => true do |t|
    t.integer   "versioned_id"
    t.string    "versioned_type"
    t.text      "changes"
    t.integer   "number"
    t.timestamp "created_at"
  end

  add_index "versions", ["created_at"], :name => "index_versions_on_created_at"
  add_index "versions", ["number"], :name => "index_versions_on_number"
  add_index "versions", ["versioned_id", "versioned_type"], :name => "index_versions_on_versioned_type_and_versioned_id"

end
