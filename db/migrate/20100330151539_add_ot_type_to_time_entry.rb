class AddOtTypeToTimeEntry < ActiveRecord::Migration
  def self.up
    add_column :time_entries, :bank_overtime_hours, :boolean
  end

  def self.down
    remove_column :time_entries, :bank_overtime_hours
  end
end
