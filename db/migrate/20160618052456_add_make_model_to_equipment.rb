class AddMakeModelToEquipment < ActiveRecord::Migration
  def up
  	add_column :equipment, :equipment_make, :string
  	add_column :equipment, :equipment_model, :string
  	add_column :equipment, :equipment_year, :string
  end

  def down
    remove_column :equipment, :equipment_make, :string
  	remove_column :equipment, :equipment_model, :string
  	remove_column :equipment, :equipment_year, :string
  end
end
