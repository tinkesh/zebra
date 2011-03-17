class RemoveEquipmentFromJobAddToCrew < ActiveRecord::Migration
  def self.up
    drop_table :equipment_jobs

    create_table :crews_equipment, :id => false, :force => true do |t|
      t.integer :equipment_id
      t.integer :crew_id
      t.timestamps
    end
  end

  def self.down
    drop_table :crews_equipment

    create_table "equipment_jobs", :id => false, :force => true do |t|
      t.integer   "equipment_id"
      t.integer   "job_id"
      t.timestamp "created_at"
      t.timestamp "updated_at"
    end
  end
end
