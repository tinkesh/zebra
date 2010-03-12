class CreateJobQuantities < ActiveRecord::Migration
  def self.up

    drop_table :gun_markings_jobs
    
    create_table :job_markings, :force => true do |t|
      t.integer :job_id
      t.integer :gun_marking_category_id
      t.integer :amount
      t.integer :rate
      t.timestamps
    end

  end

  def self.down
    drop_table :job_markings
    create_table "gun_markings_jobs", :id => false, :force => true do |t|
      t.integer "job_id"
      t.integer "gun_marking_id"
      t.integer "quantity"
      t.decimal "rate"
    end
    
  end
end
