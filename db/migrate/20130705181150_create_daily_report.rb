class CreateDailyReport < ActiveRecord::Migration
  def change
    create_table :daily_reports do |t|
      t.integer :user_id
      t.boolean :loaded, :default => false
      t.boolean :painted, :default => false

      t.timestamps
    end
  end
end
