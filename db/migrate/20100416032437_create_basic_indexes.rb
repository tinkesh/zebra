class CreateBasicIndexes < ActiveRecord::Migration
  def self.up
    add_index :time_entries, :clock_in
    add_index :time_entries, :user_id
    add_index :gun_sheets, :job_id
    add_index :load_sheets, :job_id
    add_index :gun_markings, :gun_sheet_id
    add_index :job_markings, :job_id
    add_index :job_markings, :gun_marking_category_id
    add_index :job_sheets, :job_id
    add_index :load_entries, :load_sheet_id

  end

  def self.down
    remove_index :time_entries, :clock_in
    remove_index :time_entries, :user_id
    remove_index :gun_sheets, :job_id
    remove_index :load_sheets, :job_id
    remove_index :gun_markings, :gun_sheet_id
    remove_index :job_markings, :job_id
    remove_index :job_markings, :gun_marking_category_id
    remove_index :job_sheets, :job_id
    remove_index :load_entries, :load_sheet_id
  end
end
