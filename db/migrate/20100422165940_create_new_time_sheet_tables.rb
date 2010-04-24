class CreateNewTimeSheetTables < ActiveRecord::Migration
  def self.up
    create_table :jobs_time_entries, :force => true do |t|
      t.integer :job_id
      t.integer :time_entry_id
      t.decimal :hours
      t.timestamps
    end

    create_table :jobs_time_sheets, :force => true do |t|
      t.integer :job_id
      t.integer :time_sheet_id
    end

    remove_column :time_entries, :job_id
    remove_column :time_sheets, :job_id
  end

  def self.down
    drop_table :jobs_time_sheets
    drop_table :jobs_time_entries

    add_column :time_entries, :job_id, :integer
    add_column :time_sheets, :job_id, :integer
  end
end
