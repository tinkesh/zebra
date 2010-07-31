class AddEquipmentIdToGunSheets < ActiveRecord::Migration
  def self.up
    add_column :gun_sheets, :equipment_id,  :integer
  end

  def self.down
    remove_column :gun_sheets, :equipment_id
  end
end
