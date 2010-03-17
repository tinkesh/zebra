class CreateJobSheet < ActiveRecord::Migration
  def self.up

    create_table :job_sheets, :force => true do |t|
      t.date :date
      t.integer :job_id
      t.timestamps
    end

    create_table :job_sheets_time_sheets, :force => true, :id => false do |t|
      t.integer :job_sheet_id
      t.integer :time_sheet_id
    end

    create_table :gun_sheets_job_sheets, :force => true, :id => false do |t|
      t.integer :gun_sheet_id
      t.integer :job_sheet_id
    end

  end

  def self.down
    drop_table :job_sheets_time_sheets
    drop_table :gun_sheets_job_sheets
    drop_table :job_sheets
  end

end