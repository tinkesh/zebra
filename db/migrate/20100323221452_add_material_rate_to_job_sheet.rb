class AddMaterialRateToJobSheet < ActiveRecord::Migration
  def self.up

    add_column :job_sheets, :material_rate, :decimal

  end

  def self.down
    remove_column :job_sheets, :material_rate
  end
end
