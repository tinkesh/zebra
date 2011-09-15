class JobMarking < ActiveRecord::Base

  belongs_to :job
  belongs_to :gun_marking_category


  def actual_production
    actual = 0
    gun_markings = job.gun_markings.find_all_by_gun_marking_category_id(self.gun_marking_category_id)
    gun_markings.each do |marking|
      actual += marking.amount if marking.amount
    end
    actual
  end

  def is_archived
    self.job ? self.job.is_archived : true
  end

  def total_value
    amount * rate rescue 0
  end

  def total_value_if_active
    if self.job
      self.job.is_archived ? 0 : total_value
    else
      0
    end
  end

end
