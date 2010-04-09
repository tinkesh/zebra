class AddVersionSupportFieldsToTimeSheets < ActiveRecord::Migration
  def self.up
    add_column :time_sheets, :versioned_at, :datetime
    add_column :time_sheets, :versioned_time_entry_ids, :string
  end

  def self.down
    remove_column :time_sheets, :versioned_at
    remove_column :time_sheets, :versioned_time_entry_ids
  end
end
