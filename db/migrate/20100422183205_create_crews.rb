class CreateCrews < ActiveRecord::Migration
  def self.up
    create_table :crews, :force => true do |t|
      t.string :name
      t.timestamps
    end
    add_column :users, :crew_id, :integer
    drop_table :jobs_users

    create_table :crews_jobs, :force => true, :id => false do |t|
      t.integer :crew_id
      t.integer :job_id
    end
  end

  def self.down
    drop_table :crews_jobs
    create_table "jobs_users", :id => false, :force => true do |t|
      t.integer   "job_id"
      t.integer   "user_id"
      t.timestamp "created_at"
      t.timestamp "updated_at"
    end
    remove_column :users, :crew_id
    drop_table :crews
  end
end
