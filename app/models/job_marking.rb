class JobMarking < ActiveRecord::Base

  belongs_to :job
  belongs_to :gun_marking_category

end