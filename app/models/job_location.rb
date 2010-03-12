class JobLocation < ActiveRecord::Base

  belongs_to :job
#  validates_presence_of :name, :on => :create, :message => "can't be blank"
#  validates_presence_of :job, :on => :create, :message => "can't be blank"

end