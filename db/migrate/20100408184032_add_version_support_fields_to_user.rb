class AddVersionSupportFieldsToUser < ActiveRecord::Migration
  def self.up

    add_column :users, :versioned_role_ids, :string
    add_column :users, :versioned_at, :datetime

  end

  def self.down
    remove_column :users, :versioned_at
    remove_column :users, :versioned_role_ids
  end
end
