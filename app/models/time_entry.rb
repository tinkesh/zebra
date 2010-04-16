class TimeEntry < ActiveRecord::Base

  versioned

  belongs_to :time_sheet
  belongs_to :user
  belongs_to :job

  def hours
    if self.clock_out && self.clock_in : (self.clock_out - self.clock_in)/3600 else 0 end
  end

  def per_diem
    if (self.time_sheet && self.time_sheet.per_diem == true) : self.time_sheet.per_diem_rate else 0 end
  end

  def straight_time
    if self.hours >= 10 : 10 else self.hours end
  end

  def over_time
    if self.hours >= 10 : (self.hours - 10) else 0 end
  end

  def cost
    (self.straight_time.to_f * self.rate) + (self.over_time.to_f * self.rate * 1.5) + self.per_diem.to_f
  end

end