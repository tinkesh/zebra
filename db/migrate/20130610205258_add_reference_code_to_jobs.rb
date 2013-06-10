class AddReferenceCodeToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :reference_code, :string
  end
end
