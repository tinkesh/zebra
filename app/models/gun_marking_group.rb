class GunMarkingGroup < ActiveRecord::Base

  has_many :gun_marking_categories

  def total_value
    self.gun_marking_categories.collect{|m| m.total_value}.sum
  end
end
