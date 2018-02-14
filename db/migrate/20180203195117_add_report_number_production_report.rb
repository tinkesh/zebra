class AddReportNumberProductionReport < ActiveRecord::Migration
  def up
  	add_column :production_reports, :report_number, :integer
  end

  def down
  	remove_column :production_reports, :report_number
  end
end
