class ChangeUserEmploymentNotesToText < ActiveRecord::Migration
  def up
  	change_column :users, :employment_notes, :text
  end

  def down
  	change_column :users, :employment_notes, :string
  end
end
