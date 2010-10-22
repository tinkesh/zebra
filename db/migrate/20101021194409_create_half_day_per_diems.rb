class CreateHalfDayPerDiems < ActiveRecord::Migration
  def self.up

    rename_column :time_sheets, :per_diem, :per_diem_boolean
    add_column :time_sheets, :per_diem_percent, :decimal, :default => 0

    @ts = TimeSheet.all
    @ts.each do |ts|
      ts.per_diem_boolean == false ? ts.update_attributes(:per_diem_percent => 0) : ts.update_attributes(:per_diem_percent => 1)
    end

    remove_column :time_sheets, :per_diem_boolean

  end

  def self.down
    add_column :time_sheets, :per_diem_boolean, :boolean
    remove_column :time_sheets, :per_diem_percent
    rename_column :time_sheets, :per_diem_boolean, :per_diem
  end
end