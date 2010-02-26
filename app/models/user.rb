class User < ActiveRecord::Base
  acts_as_authentic
  
  has_and_belongs_to_many :roles
  has_and_belongs_to_many :jobs
  attr_accessible :login, :password, :password_confirmation, :email, :first_name, :last_name,:role_ids, :time_zone
  
  #for declarative authorization
  def role_symbols
    roles.map do |role|
      role.name.underscore.to_sym
    end
  end
  
  def deliver_password_reset_instructions!
    reset_perishable_token!
    Notifier.deliver_password_reset_instructions(self)
  end

  def name
    self.first_name + " " + self.last_name
  end
  
  def role_list
    list = Array.new
    roles.each do |role|
      list << role.name
    end
    list.join(", ")
  end

end
