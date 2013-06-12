class AddFlagAlertsToEquipment < ActiveRecord::Migration
  def change
    add_column :equipment, :red_flag_alert_sent_at, :datetime
    add_column :equipment, :black_flag_alert_sent_at, :datetime
  end
end
