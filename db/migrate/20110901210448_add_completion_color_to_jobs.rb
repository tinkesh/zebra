class AddCompletionColorToJobs < ActiveRecord::Migration
  def self.up
    add_column :jobs, :completion_color, :string
  end

  def self.down
    remove_column :jobs, :completion_color
  end
end
