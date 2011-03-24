class ChangeLoadSheetNumberTypes < ActiveRecord::Migration
  def self.up
    change_column :load_sheets, :yellow_dip_start, :decimal, :scale => 2, :precision => 5, :default => 0.0
    change_column :load_sheets, :yellow_dip_end, :decimal, :scale => 2, :precision => 5, :default => 0.0
    change_column :load_sheets, :white_dip_start, :decimal, :scale => 2, :precision => 5, :default => 0.0
    change_column :load_sheets, :white_dip_end, :decimal, :scale => 2, :precision => 5, :default => 0.0
    
    change_column :load_sheets, :adjusted_yellow_dip_start, :decimal, :scale => 2, :precision => 5, :default => 0.0
    change_column :load_sheets, :adjusted_yellow_dip_end, :decimal, :scale => 2, :precision => 5, :default => 0.0
    change_column :load_sheets, :adjusted_white_dip_start, :decimal, :scale => 2, :precision => 5, :default => 0.0
    change_column :load_sheets, :adjusted_white_dip_end, :decimal, :scale => 2, :precision => 5, :default => 0.0

  end

  def self.down
    change_column :load_sheets, :yellow_dip_start, :integer
    change_column :load_sheets, :yellow_dip_end, :integer
    change_column :load_sheets, :white_dip_start, :integer
    change_column :load_sheets, :white_dip_end, :integer
    
    change_column :load_sheets, :adjusted_yellow_dip_start, :integer
    change_column :load_sheets, :adjusted_yellow_dip_end, :integer
    change_column :load_sheets, :adjusted_white_dip_start, :integer
    change_column :load_sheets, :adjusted_white_dip_end, :integer
  end
end
