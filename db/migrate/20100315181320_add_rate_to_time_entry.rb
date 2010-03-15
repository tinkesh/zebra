class AddRateToTimeEntry < ActiveRecord::Migration
  def self.up
    add_column :time_entries, :rate, :integer
  end

  def self.down
    remove_column :time_entries, :rate
  end
end
