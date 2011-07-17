class ChangeJobMarkingRateToDecimal < ActiveRecord::Migration
  def self.up
    change_column :job_markings, :rate, :decimal, :scale => 2, :precision => 9
  end

  def self.down
    change_column :job_markings, :rate, :integer
  end
end
