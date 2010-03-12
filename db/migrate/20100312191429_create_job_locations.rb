class CreateJobLocations < ActiveRecord::Migration
  def self.up

    drop_table :locations
    drop_table :jobs_locations

    create_table :job_locations, :force => true do |t|
      t.integer :job_id
      t.string :name
      t.timestamps
    end

  end

  def self.down
    drop_table :job_locations
    create_table "jobs_locations", :id => false, :force => true do |t|
      t.integer  "job_id"
      t.integer  "location_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "locations", :force => true do |t|
      t.string   "name"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

  end
end