class ChangeCompletedByToString < ActiveRecord::Migration
  def up
  	  	change_column :production_reports, :completed_by, :string
  end

  def down
  	  	change_column :production_reports, :completed_by, :integer
  end
end
