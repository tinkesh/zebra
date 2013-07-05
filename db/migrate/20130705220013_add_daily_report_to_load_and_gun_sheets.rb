class AddDailyReportToLoadAndGunSheets < ActiveRecord::Migration
  def change
    add_column :gun_sheets, :daily_report_id, :integer
    add_column :load_sheets, :daily_report_id, :integer
  end
end
