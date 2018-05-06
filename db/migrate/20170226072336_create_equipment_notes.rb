class CreateEquipmentNotes < ActiveRecord::Migration
  def change
    create_table :equipment_notes do |t|
      t.text :description
      t.integer :user_id
      t.integer :equipment_id
      t.timestamps
    end
  end
end
