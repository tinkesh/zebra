class AddStartedOnAndCompletedOnToGunSheets < ActiveRecord::Migration
  def self.up
    rename_column :gun_sheets, :date, :started_on
    add_column :gun_sheets, :completed_on, :date
  end

  def self.down
    remove_column :gun_sheets, :completed_on
    rename_column :gun_sheets, :started_on, :date
  end
end
