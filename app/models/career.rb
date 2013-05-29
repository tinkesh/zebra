class Career < ActiveRecord::Base

  validates_presence_of :name, :on => :create, :message => "can't be blank"
  validates_presence_of :address, :on => :create, :message => "can't be blank"
  validates_presence_of :city, :on => :create, :message => "can't be blank"
  validates_presence_of :province, :on => :create, :message => "can't be blank"
  validates_presence_of :phone, :on => :create, :message => "can't be blank"
  validates_presence_of :references, :on => :create, :message => "can't be blank"

  after_create :deliver_new_career

  def deliver_new_career
    SiteMailer.new_career(self).deliver
  end

end
