class AddYellowRateAndWhiteRateToEquipment < ActiveRecord::Migration
  def self.up
    add_column :equipment, :yellow_rate, :integer
    add_column :equipment, :white_rate, :integer
    remove_column :material_reports, :yellow_rate
    remove_column :material_reports, :white_rate
  end

  def self.down
    remove_column :equipment, :yellow_rate
    remove_column :equipment, :white_rate
    add_column :material_reports, :yellow_rate, :integer
    add_column :material_reports, :white_rate, :integer
  end
end
