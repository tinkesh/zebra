class AddLocationToGunSheet < ActiveRecord::Migration
  def self.up
    
    add_column :gun_sheets, :location_name, :string
    remove_column :gun_sheets, :location_id
    add_column :gun_sheets, :job_location_id, :integer
  end

  def self.down
    remove_column :gun_sheets, :job_location_id
    add_column :gun_sheets, :location_id, :integer
    remove_column :gun_sheets, :location_name
  end
end
