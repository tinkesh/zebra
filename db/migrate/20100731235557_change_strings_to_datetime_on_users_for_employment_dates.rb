class ChangeStringsToDatetimeOnUsersForEmploymentDates < ActiveRecord::Migration
  def self.up

    change_column :users, :employment_start_date, :datetime
    change_column :users, :employment_end_date, :datetime
  end

  def self.down
  end
end
