class AddPerDiemAmountToTimeSheets < ActiveRecord::Migration
  def self.up
    add_column :time_sheets, :per_diem_rate, :integer
  end

  def self.down
    remove_column :time_sheets, :per_diem_rate
  end
end
