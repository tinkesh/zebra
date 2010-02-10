class AddContactInformationToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :home_phone, :string
    add_column :users, :cell_phone, :string
    add_column :users, :address, :string
    add_column :users, :city, :string
    add_column :users, :province, :string
    add_column :users, :postal_code, :string
  end

  def self.down
    remove_column :users, :postal_code
    remove_column :users, :province
    remove_column :users, :city
    remove_column :users, :address
    remove_column :users, :cell_phone
    remove_column :users, :home_phone
  end
end
