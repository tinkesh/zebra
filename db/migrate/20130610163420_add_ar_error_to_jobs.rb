class AddArErrorToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :ar_error, :boolean, :default => false
  end
end
