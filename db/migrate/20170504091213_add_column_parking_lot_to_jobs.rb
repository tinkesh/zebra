class AddColumnParkingLotToJobs < ActiveRecord::Migration
  def up
  	add_column :jobs, :parking_lot_division, :boolean, default: false
  end

  def down
  	remove_column :jobs, :parking_lot_division
  end
end
