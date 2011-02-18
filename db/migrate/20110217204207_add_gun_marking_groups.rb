class AddGunMarkingGroups < ActiveRecord::Migration
  def self.up
    create_table :gun_marking_groups do |t|
      t.string :title
      t.timestamps
    end

    GunMarkingGroup.create(:title => "Unassigned")
    GunMarkingGroup.create(:title => "Line Painting")
    GunMarkingGroup.create(:title => "Line Removal")
    GunMarkingGroup.create(:title => "Durables")
    GunMarkingGroup.create(:title => "Other")

    add_column :gun_marking_categories, :gun_marking_group_id, :integer

    @markings = GunMarkingCategory.all
    @markings.each do |m|
      m.update_attributes(:gun_marking_group_id => 1)
    end
  end

  def self.down
    remove_column :gun_marking_categories, :gun_marking_group_id

    drop_table :gun_marking_groups
  end
end
