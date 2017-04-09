class CreateLabours < ActiveRecord::Migration
  def change
    create_table :labours do |t|
      t.string :mechanic_name
      t.integer :hours_on_job
      t.integer :hourly_rate
      t.integer :work_order_id
      t.timestamps
    end
  end
end
