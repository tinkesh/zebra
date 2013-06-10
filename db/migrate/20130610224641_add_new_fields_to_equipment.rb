class AddNewFieldsToEquipment < ActiveRecord::Migration
  def change
    add_column :equipment, :plate_number, :string
    add_column :equipment, :vin, :string
    add_column :equipment, :gvw, :string
    add_column :equipment, :registration_date, :date
    add_column :equipment, :cvip_date, :date
    add_column :equipment, :color, :string
  end
end
