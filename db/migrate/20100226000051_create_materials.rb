class CreateMaterials < ActiveRecord::Migration
  def self.up
    create_table :materials, :force => true do |t|
      t.integer :manufacturer_id
      t.string :batch
      t.string :category
      t.integer :litre_per_tote
      t.timestamps
    end
  end

  def self.down
    drop_table :materials
  end
end
