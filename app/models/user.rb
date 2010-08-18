class User < ActiveRecord::Base
  acts_as_authentic
  versioned :only => [:first_name, :last_name, :rate, :login, :email, :time_zone, :home_phone, :cell_phone, :address, :city, :province, :postal_code, :bank_overtime_hours, :versioned_role_ids, :versioned_at]

  belongs_to :crew
  has_many :time_entries
  has_and_belongs_to_many :roles

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :rate
  # attr_accessible :login, :password, :password_confirmation, :email, :first_name, :last_name,:role_ids, :time_zone

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

