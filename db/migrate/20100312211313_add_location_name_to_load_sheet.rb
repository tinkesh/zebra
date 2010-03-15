class AddLocationNameToLoadSheet < ActiveRecord::Migration
  def self.up
    add_column :load_sheets, :location_name, :string
  end

  def self.down
    remove_column :load_sheets, :location_name
  end
end
