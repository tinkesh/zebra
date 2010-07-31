class AddEmploymentToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :employment_state, :string, :default => "Employed"
    add_column :users, :employment_start_date, :string
    add_column :users, :employment_end_date, :string
    add_column :users, :employment_notes, :string
  end

  def self.down
    remove_column :users, :employment_state
    remove_column :users, :employment_start_date
    remove_column :users, :employment_end_date
    remove_column :users, :employment_notes
  end
end
