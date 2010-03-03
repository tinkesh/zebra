class AddCreatedByAndNameToTimeSheetTables < ActiveRecord::Migration
  def self.up
    add_column :time_entries, :name, :string
    add_column :time_entries, :created_by, :integer
    add_column :time_sheets, :created_by, :integer
    add_column :time_tasks, :created_by, :integer
    add_column :time_sheets, :note, :string
    add_column :time_sheets, :started_at, :datetime
    add_column :time_sheets, :completed_at, :datetime
    add_column :time_sheets, :updated_by, :integer
    add_column :time_tasks, :updated_by, :integer
    add_column :time_entries, :updated_by, :integer
  end

  def self.down
    remove_column :time_entries, :updated_by
    remove_column :time_tasks, :updated_by
    remove_column :time_sheets, :updated_by
    remove_column :time_sheets, :completed_at
    remove_column :time_sheets, :started_at
    remove_column :time_sheets, :note
    remove_column :time_tasks, :created_by
    remove_column :time_sheets, :created_by
    remove_column :time_entries, :created_by
    remove_column :time_entries, :name
  end
end
