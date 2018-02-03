class ChangeUserCreatedAtToDatetime < ActiveRecord::Migration
  def up
  	change_column :production_reports, :user_created_at, :datetime
  end

  def down
  	change_column :production_reports, :user_created_at, :date
  end
end
