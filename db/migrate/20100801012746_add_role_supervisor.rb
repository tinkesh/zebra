class AddRoleSupervisor < ActiveRecord::Migration
  def self.up
    Role.create(:name => "supervisor")
  end

  def self.down
  end
end
