class CreateJobs < ActiveRecord::Migration
  def self.up
    create_table :jobs, :force => true do |t|
      t.integer :completion_id
      t.integer :client_id
      t.date :started_on
      t.date :completed_on
      t.timestamps
    end
    
    create_table :locations, :force => true do |t|
      t.string :name
      t.timestamps
    end
    
    create_table :jobs_users, :force => true, :id => false do |t|
      t.integer :job_id
      t.integer :user_id
      t.timestamps
    end
    
    create_table :equipment_jobs, :force => true, :id => false do |t|
      t.integer :equipment_id
      t.integer :job_id
      t.timestamps
    end
    
    create_table :jobs_locations, :force => true, :id => false do |t|
      t.integer :job_id
      t.integer :location_id
      t.timestamps
    end
  end

  def self.down
    drop_table :locations
    drop_table :jobs_locations
    drop_table :equipment_jobs
    drop_table :jobs_users
    drop_table :jobs
  end
end
