class ChangeLoadSheetColumnDefaults < ActiveRecord::Migration
  def self.up
    change_column :load_sheets, :yellow_dip_start, :decimal, :default => nil
    change_column :load_sheets, :yellow_dip_end, :decimal, :default => nil
    change_column :load_sheets, :white_dip_start, :decimal, :default => nil
    change_column :load_sheets, :white_dip_end, :decimal, :default => nil

    change_column :load_sheets, :adjusted_yellow_dip_start, :decimal, :default => nil
    change_column :load_sheets, :adjusted_yellow_dip_end, :decimal, :default => nil
    change_column :load_sheets, :adjusted_white_dip_start, :decimal, :default => nil
    change_column :load_sheets, :adjusted_white_dip_end, :decimal, :default => nil
  end

  def self.down
  end
end
