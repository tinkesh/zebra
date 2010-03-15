class AddAmountToManufacturers < ActiveRecord::Migration
  def self.up
    add_column :manufacturers, :amount, :integer
  end

  def self.down
    remove_column :manufacturers, :amount
  end
end
