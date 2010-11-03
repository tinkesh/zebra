class RemoveLoadEntryCategory < ActiveRecord::Migration
  def self.up
    remove_column :load_entries, :category
  end

  def self.down
    add_column :load_entries, :category, :string
  end
end