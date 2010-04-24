class CreateMaterialReports < ActiveRecord::Migration
  def self.up
    create_table :material_reports, :force => true do |t|
      t.references :job
      t.decimal :yellow_rate
      t.decimal :white_rate
      t.timestamps
    end

    create_table :gun_sheets_material_reports, :force => true, :id => false do |t|
      t.references :gun_sheet
      t.references :material_report
    end

    create_table :load_sheets_material_reports, :force => true, :id => false do |t|
      t.references :load_sheet
      t.references :material_report
    end

  end

  def self.down
    drop_table :load_sheets_material_reports
    drop_table :gun_sheets_material_reports
    drop_table :material_reports
  end
end
