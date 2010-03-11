class AddDetailFieldsToJobs < ActiveRecord::Migration
  def self.up
    add_column :jobs, :name, :string
    add_column :jobs, :notes, :text
    add_column :jobs, :location_name, :string

    create_table :gun_markings_jobs, :id => false, :force => true do |t|
      t.integer :job_id
      t.integer :gun_marking_id
      t.integer :quantity
      t.decimal :rate
    end

  end

  def self.down
    drop_table :gun_markings_jobs
    remove_column :jobs, :location_name
    remove_column :jobs, :notes
    remove_column :jobs, :name
  end
end
