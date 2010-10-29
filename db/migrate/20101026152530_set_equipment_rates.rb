class SetEquipmentRates < ActiveRecord::Migration
  def self.up

    remove_column :equipment, :yellow_rate
    remove_column :equipment, :white_rate
    add_column :equipment, :yellow_rate, :decimal, :scale => 2, :precision => 5
    add_column :equipment, :white_rate, :decimal, :scale => 2, :precision => 5

    @equipments = Equipment.all
    @equipments.each do |e|
      e.update_attributes(:yellow_rate => "33.97", :white_rate => "33.97")
    end

  end

  def self.down
    remove_column :equipment, :white_rate
    remove_column :equipment, :yellow_rate
    add_column :equipment, :white_rate, :integer
    add_column :equipment, :yellow_rate, :integer
  end
end
