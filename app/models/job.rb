class Job < ActiveRecord::Base

  belongs_to :client
  belongs_to :completion
  has_and_belongs_to_many :users
  has_and_belongs_to_many :equipments
  has_and_belongs_to_many :locations

end
