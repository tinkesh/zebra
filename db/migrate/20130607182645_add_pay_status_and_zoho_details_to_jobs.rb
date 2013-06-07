class AddPayStatusAndZohoDetailsToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :pay_status, :string
    add_column :jobs, :zoho_details, :text
  end
end
