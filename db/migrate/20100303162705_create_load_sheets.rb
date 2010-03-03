class CreateLoadSheets < ActiveRecord::Migration
  def self.up
    
    create_table :load_sheets, :force => true do |t|
      t.integer :equipment_id
      t.integer :location_id
      t.integer :job_id
      t.integer :yellow_dip_start
      t.integer :yellow_dip_end
      t.integer :white_dip_start
      t.integer :white_dip_end
      t.date :date
      t.string :note
      t.timestamps
    end
    
    create_table :load_entries, :force => true do |t|
      t.integer :load_sheet_id
      t.integer :material_id
      t.decimal :tote_number
      t.decimal :tote_quantity
      t.timestamps
    end
    
  end

  def self.down
    drop_table :load_entries
    drop_table :load_sheets
  end
end
