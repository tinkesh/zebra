class AddIsArchivedToMaterials < ActiveRecord::Migration
  def self.up
    add_column :materials, :is_archived, :boolean, :default => false
  end

  def self.down
    remove_column :materials, :is_archived
  end
end
