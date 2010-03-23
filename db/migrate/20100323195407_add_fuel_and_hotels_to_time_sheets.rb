class AddFuelAndHotelsToTimeSheets < ActiveRecord::Migration
  def self.up
    add_column :time_sheets, :fuel, :decimal
    add_column :time_sheets, :hotel, :decimal
    add_column :time_sheets, :fuel_rate, :decimal
  end

  def self.down
    remove_column :time_sheets, :fuel_rate
    remove_column :time_sheets, :hotel
    remove_column :time_sheets, :fuel
  end
end
