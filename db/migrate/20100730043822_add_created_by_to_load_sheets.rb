class AddCreatedByToLoadSheets < ActiveRecord::Migration
  def self.up
     add_column :load_sheets, :created_by,  :integer
  end

  def self.down
     remove_column :load_sheets, :created_by
  end
end
