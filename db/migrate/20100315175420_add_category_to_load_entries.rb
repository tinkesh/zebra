class AddCategoryToLoadEntries < ActiveRecord::Migration
  def self.up
    add_column :load_entries, :category, :string

  end

  def self.down
    remove_column :load_entries, :category
  end
end
