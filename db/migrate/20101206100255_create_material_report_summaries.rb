class CreateMaterialReportSummaries < ActiveRecord::Migration
  def self.up
    create_table :material_report_summaries do |t|
      t.references :job
      t.references :user
      t.timestamps
    end

    create_table :gun_sheets_material_report_summaries, :force => true, :id => false do |t|
      t.references :gun_sheet
      t.references :material_report_summary
    end
  end

  def self.down
    drop_table :material_report_summaries
    drop_table :gun_sheets_material_report_summaries
  end
end
