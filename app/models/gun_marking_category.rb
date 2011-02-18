class GunMarkingCategory < ActiveRecord::Base

  has_many :gun_markings
  has_many :job_markings
  belongs_to :gun_marking_group

  named_scope :categories_for_group, lambda { |group_id| { :conditions => ['gun_marking_group_id = ?', group_id]}}

  def total_value
    self.job_markings.collect{|m| m.total_value_if_active}.sum
  end

  def num_job_markings
    self.job_markings.count
  end
end
