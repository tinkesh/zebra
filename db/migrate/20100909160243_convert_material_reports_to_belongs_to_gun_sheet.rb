class ConvertMaterialReportsToBelongsToGunSheet < ActiveRecord::Migration
  def self.up

    drop_table :gun_sheets_material_reports
    drop_table :load_sheets_material_reports

    add_column :material_reports, :gun_sheet_id, :integer
    add_column :material_reports, :load_sheet_id, :integer

  end

  def self.down
    remove_column :material_reports, :load_sheet_id
    remove_column :material_reports, :gun_sheet_id

    create_table "load_sheets_material_reports", :id => false, :force => true do |t|
      t.integer "load_sheet_id"
      t.integer "material_report_id"
    end

    create_table "gun_sheets_material_reports", :id => false, :force => true do |t|
      t.integer "gun_sheet_id"
      t.integer "material_report_id"
    end

  end
end
