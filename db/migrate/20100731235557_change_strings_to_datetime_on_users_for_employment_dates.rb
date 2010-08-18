class ChangeStringsToDatetimeOnUsersForEmploymentDates < ActiveRecord::Migration
  def self.up
    change_column :users, :employment_start_date, :date
    change_column :users, :employment_end_date, :date
  end

  def self.down
  end
end
