class AddVersionSupportFieldsToJobs < ActiveRecord::Migration
  def self.up
    add_column :jobs, :versioned_user_ids, :string
    add_column :jobs, :versioned_equipment_ids, :string
    add_column :jobs, :versioned_at, :datetime
  end

  def self.down
    remove_column :jobs, :versioned_at
    remove_column :jobs, :versioned_equipment_ids
    remove_column :jobs, :versioned_user_ids
  end
end
