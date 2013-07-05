class RecreateTimeEntries < ActiveRecord::Migration
  def self.up

    drop_table :time_entries
    create_table :time_entries, :force => true do |t|
      t.integer :job_id
      t.integer :user_id
      t.integer :time_sheet_id
      t.date :date
      t.datetime :clock_in
      t.datetime :clock_out
      t.string :note
      t.decimal :rate
      t.datetime :clocked_in_at
      t.datetime :clocked_out_at
      t.integer :clocked_in_by
      t.integer :clocked_out_by
      t.boolean :active
      t.timestamps
    end

  end

  def self.down
    drop_table :time_entries
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
      t.integer  "rate"
    end

  end
end
