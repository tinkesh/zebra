class CreateTimeSheetsAndRelatedTables < ActiveRecord::Migration
  def self.up

    create_table :time_note_categories, :force => true do |t|
      t.string :name
      t.integer :position
    end

    create_table :time_task_categories, :force => true do |t|
      t.string :name
      t.integer :position
    end

    create_table :time_sheets, :force => true do |t|
      t.integer :job_id
      t.integer :location_id
      t.integer :time_note_category_id
      t.timestamps
    end

    create_table :time_tasks, :force => true do |t|
      t.integer :time_sheet_id
      t.integer :time_task_category_id
      t.datetime :happened_at
      t.decimal :time
      t.string  :note
      t.timestamps
    end

    create_table :time_entries, :force => true do |t|
      t.integer :time_sheet_id
      t.integer :user_id
      t.decimal :time
      t.string :note
      t.timestamps
    end

  end

  def self.down
    drop_table :time_task_categories
    drop_table :time_note_categories
    drop_table :time_entries
    drop_table :time_tasks
    drop_table :time_sheets
  end
end
