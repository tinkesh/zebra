class CreateParts < ActiveRecord::Migration
  def change
    create_table :parts do |t|
      t.string :name
      t.text :description
      t.integer :quantity
      t.integer :unit_rate
      t.integer :work_order_id
      t.timestamps
    end
  end
end
