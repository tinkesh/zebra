class RenameAdjustedDipColumns < ActiveRecord::Migration
  def self.up
    rename_column :load_sheets, :adjusted_yellow_dip_stop, :adjusted_yellow_dip_end
    rename_column :load_sheets, :adjusted_white_dip_stop, :adjusted_white_dip_end
  end

  def self.down
    rename_column :load_sheets, :adjusted_white_dip_end, :adjusted_white_dip_stop
    rename_column :load_sheets, :adjusted_, :adjusted_yellow_dip_stop
  end
end
