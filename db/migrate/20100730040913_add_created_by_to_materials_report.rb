class AddCreatedByToMaterialsReport < ActiveRecord::Migration
  def self.up
        add_column :material_reports, :created_by,  :integer
  end

  def self.down
        remove_column :gun_sheets, :created_by
  end
end
