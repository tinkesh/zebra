class ChangeJobLocationNameToText < ActiveRecord::Migration
  def up
    change_column :job_locations, :name, :text
  end

  def down
    change_column :job_locations, :name, :string
  end
end
