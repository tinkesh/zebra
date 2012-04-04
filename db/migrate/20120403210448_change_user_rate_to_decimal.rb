class ChangeUserRateToDecimal < ActiveRecord::Migration
  def self.up
    change_column :users, :rate, :decimal, :default=>0.0, :precision=>6, :scale=>2
    change_column :time_entries, :rate, :decimal, :default=>0.0, :precision=>6, :scale=>2
  end

  def self.down
    change_column :users, :rate, :integer
    change_column :time_entries, :rate, :integer
  end
end
