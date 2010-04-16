class AddVersionedAtToLoadAndGunSheets < ActiveRecord::Migration
  def self.up
    add_column :load_sheets, :versioned_at, :datetime
    add_column :gun_sheets, :versioned_at, :datetime

  end

  def self.down
    remove_column :gun_sheets, :versioned_at
    remove_column :load_sheets, :versioned_at
  end
end
