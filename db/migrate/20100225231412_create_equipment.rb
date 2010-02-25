class CreateEquipment < ActiveRecord::Migration
  def self.up
    
    create_table :equipment, :force => true do |t|
      t.string :unit
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :equipment
  end
end
