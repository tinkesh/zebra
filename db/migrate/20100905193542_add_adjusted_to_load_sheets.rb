class AddAdjustedToLoadSheets < ActiveRecord::Migration
  def self.up
    add_column :load_sheets, :adjusted_yellow_dip_start, :integer, :default => 0
    add_column :load_sheets, :adjusted_yellow_dip_stop, :integer, :default => 0 
    add_column :load_sheets, :adjusted_white_dip_start, :integer, :default => 0 
    add_column :load_sheets, :adjusted_white_dip_stop, :integer, :default => 0
  end

  def self.down
    remove_column :load_sheets, :adjusted_yellow_dip_start
    remove_column :load_sheets, :adjusted_yellow_dip_stop
    remove_column :load_sheets, :adjusted_white_dip_start
    remove_column :load_sheets, :adjusted_white_dip_stop
  end
end
