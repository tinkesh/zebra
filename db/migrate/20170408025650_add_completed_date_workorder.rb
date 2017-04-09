class AddCompletedDateWorkorder < ActiveRecord::Migration
  def change
  	add_column :work_orders, :service_performed_notes, :text
  	add_column :work_orders, :created_date, :datetime
  	add_column :work_orders, :completed_date, :datetime
  end
end
