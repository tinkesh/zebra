class AddIsArchivedToJobs < ActiveRecord::Migration
  def self.up
      add_column :jobs, :is_archived, :boolean, :default => false
  end

  def self.down
    remove_column :jobs, :is_archived
  end
end
