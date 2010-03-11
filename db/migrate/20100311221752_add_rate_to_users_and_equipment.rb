class AddRateToUsersAndEquipment < ActiveRecord::Migration
  def self.up
    add_column :users, :rate, :integer
    add_column :equipment, :rate, :integer
  end

  def self.down
    remove_column :equipment, :rate
    remove_column :users, :rate
  end
end
