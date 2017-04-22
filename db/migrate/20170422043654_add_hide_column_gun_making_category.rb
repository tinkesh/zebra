class AddHideColumnGunMakingCategory < ActiveRecord::Migration
  def up
  	add_column :gun_marking_categories, :hide, :boolean, default: false
  end

  def down
  	remove_column :gun_marking_categories, :hide
  end
end
