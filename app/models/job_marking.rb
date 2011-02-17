class JobMarking < ActiveRecord::Base

  belongs_to :job
  belongs_to :gun_marking_category

  def actual_production
    actual = 0
    gun_markings = job.gun_markings.find_all_by_gun_marking_category_id(self.gun_marking_category.id)
    gun_markings.each do |marking|
      actual += marking.amount
    end
    actual
  end

  def total_value
    amount * rate
  end

end
