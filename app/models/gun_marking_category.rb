class GunMarkingCategory < ActiveRecord::Base

  has_many :gun_markings
  has_many :job_markings

end
