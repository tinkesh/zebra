class AddColumnReminderOnToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :reminder_on, :datetime
    add_column :jobs, :reminder_notice, :text
    add_column :jobs, :reminder_email, :string
  end
end
