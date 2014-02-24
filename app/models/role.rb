class Role < ActiveRecord::Base
  has_and_belongs_to_many :users

  def is_high_access_role?
    ['superadmin', 'admin', 'office', 'supervisor'].include? self.name
  end
end
