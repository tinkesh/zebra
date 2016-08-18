class AddColumnAssets < ActiveRecord::Migration
  def up
  	add_column :assets, :file_type, :string, default: 'Field Documents'
  end

  def down
  	remove_column :assets, :file_type, :string
  end
end
