class ConvertEmploymentFieldsToDate < ActiveRecord::Migration
  def self.up
    change_column :users, :employment_start_date, :date
    change_column :users, :employment_end_date, :date
  end

  def self.down
    change_column :users, :employment_end_date, :text
    change_column :users, :employment_start_date, :text
  end
end