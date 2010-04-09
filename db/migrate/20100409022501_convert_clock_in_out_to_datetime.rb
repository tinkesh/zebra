class ConvertClockInOutToDatetime < ActiveRecord::Migration
  def self.up
    change_column :time_entries, :clock_in, :datetime
    change_column :time_entries, :clock_out, :datetime
  end

  def self.down
    change_column :time_entries, :clock_in, :date
    change_column :time_entries, :clock_out, :date
  end
end
