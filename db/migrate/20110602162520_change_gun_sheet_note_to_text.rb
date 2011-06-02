class ChangeGunSheetNoteToText < ActiveRecord::Migration
  def self.up
    change_column :gun_sheets, :note, :text, :limit => false
  end

  def self.down
    change_column :gun_sheets, :note, :string
  end
end
