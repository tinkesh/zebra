class AddCreatedByToJobSheets < ActiveRecord::Migration
  def self.up
    add_column :job_sheets, :created_by, :integer
  end

  def self.down
    remove_column :job_sheets, :created_by
  end
end
