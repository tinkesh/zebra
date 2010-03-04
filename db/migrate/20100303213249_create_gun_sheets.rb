class CreateGunSheets < ActiveRecord::Migration
  def self.up
    create_table :gun_sheets, :force => true do |t|
      t.integer :client_id
      t.integer :job_id
      t.integer :location_id
      t.boolean :is_new_construction
      t.string :control_section
      t.date :date
      t.time :started_at
      t.time :completed_at
      t.integer :sides
      t.integer :interchanges
      t.string :note
      t.decimal :solid_y1
      t.decimal :solid_y2
      t.decimal :solid_y3
      t.decimal :solid_w4
      t.decimal :solid_w5
      t.decimal :solid_w6
      t.decimal :solid_w7
      t.decimal :skip_y1
      t.decimal :skip_y2
      t.decimal :skip_y3
      t.decimal :skip_w4
      t.decimal :skip_w5
      t.decimal :skip_w6
      t.decimal :skip_w7
      t.integer :created_by
      t.integer :updated_by
      t.timestamps
    end
    
    create_table :gun_markings, :force => true do |t|
      t.integer :gun_sheet_id
      t.integer :gun_marking_category_id
      t.integer :amount
      t.timestamps
    end
    
    create_table :gun_marking_categories, :force => true do |t|
      t.string :name
      t.integer :position
    end

  end

  def self.down
    drop_table :gun_marking_categories
    drop_table :gun_markings
    drop_table :gun_sheets
  end
end
