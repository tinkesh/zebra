class CreateCareers < ActiveRecord::Migration
  def self.up
    create_table :careers do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :province
      t.string :phone
      t.string :email
      t.boolean :have_class5
      t.boolean :have_class3
      t.boolean :have_class1
      t.boolean :have_overtime
      t.boolean :have_travel
      t.boolean :have_firstaid
      t.boolean :have_tdg
      t.boolean :have_seasonal
      t.boolean :have_experience
      t.text :references
      t.timestamps
    end
  end

  def self.down
    drop_table :careers
  end
end
