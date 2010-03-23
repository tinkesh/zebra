class AddBankOvertimeHoursToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :bank_overtime_hours, :boolean
  end

  def self.down
    remove_column :users, :bank_overtime_hours
  end
end
