class AdditionalTimeSheetFields < ActiveRecord::Migration
  def self.up
    add_column :time_sheets, :lunch, :integer
    add_column :time_sheets, :per_diem, :boolean
  end

  def self.down
    remove_column :time_sheets, :per_diem
    remove_column :time_sheets, :lunch
  end
end
