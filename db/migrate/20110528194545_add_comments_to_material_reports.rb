class AddCommentsToMaterialReports < ActiveRecord::Migration
  def self.up
    add_column :material_reports, :comments, :text
  end

  def self.down
    remove_column :material_reports, :comments
  end
end
