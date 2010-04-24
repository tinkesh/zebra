class CreateEstimates < ActiveRecord::Migration
  def self.up
    create_table :estimates, :force => true do |t|
      t.references :job
      t.references :time_sheet
      t.decimal :hours
      t.integer :crew_size
      t.timestamps
    end

  end

  def self.down
    drop_table :estimates
  end
end
