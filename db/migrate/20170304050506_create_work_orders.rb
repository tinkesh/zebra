class CreateWorkOrders < ActiveRecord::Migration
  def change
    create_table :work_orders do |t|
      t.string :client_name
      t.string :contact_name
      t.string :phone
      t.string :hour_meter
      t.string :odometer
      t.integer :equipment_id
      t.integer :user_id
      t.timestamps
    end
  end
end
