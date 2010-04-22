class ChangeMarkingQuantitiesToDecimal < ActiveRecord::Migration
  def self.up
    change_column :gun_markings, :amount, :decimal, :precision => 2
    change_column :job_markings, :amount, :decimal, :precision => 2
  end

  def self.down
    change_column :job_markings, :amount, :integer
    change_column :gun_markings, :amount, :integer
  end
end
