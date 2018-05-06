class AddShopSuppliesToWorkOrder < ActiveRecord::Migration
  def change
  	add_column :work_orders, :shop_supplies, :integer, :default => 0
  end
end
