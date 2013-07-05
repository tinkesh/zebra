class ChangeStringsToDatetimeOnUsersForEmploymentDates < ActiveRecord::Migration
  def self.up
    remove_column :users, :employment_start_date
    remove_column :users, :employment_end_date

    add_column :users, :employment_start_date, :date
    add_column :users, :employment_end_date, :date
  end

  def self.down
  end
end
