class Contact < ActiveRecord::Base

  belongs_to :job
  validates_presence_of :name, :on => :create, :message => "can't be blank"
  validates_presence_of :email, :on => :create, :message => "can't be blank"
  validates_presence_of :subject, :on => :create, :message => "can't be blank"
  validates_presence_of :body, :on => :create, :message => "can't be blank"

  after_create :deliver_new_contact

  def deliver_new_contact
    Notifier.deliver_new_contact(self)
  end

end
