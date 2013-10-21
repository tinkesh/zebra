class TimeEntry < ActiveRecord::Base
  belongs_to :time_sheet
  belongs_to :user
  has_and_belongs_to_many :jobs

  validate do |time_entry|
    if self.clock_out.present? and self.clock_in.present? and self.clock_out <= self.clock_in
      self.errors.add :base, "Clock Out Time should be later than Clock In Time (<strong>#{self.clock_in.strftime('%Y-%m-%d %H:%M')}</strong>)".html_safe
    end
  end

  def hours
    if self.clock_out && self.clock_in && self.time_sheet
      ((self.clock_out - self.clock_in - (self.time_sheet.lunch * 60))/3600)
    elsif self.clock_out && self.clock_in
      ((self.clock_out - self.clock_in)/3600)
    else
      0
    end
  end

  def per_diem
    if self.time_sheet.present? && self.time_sheet.per_diem_percent.present?
      self.time_sheet.per_diem_percent
    else
      0
    end
  end

  def per_diem_cost
    (self.per_diem * self.time_sheet.per_diem_rate) rescue 0
  end

  def straight_time
    self.hours >= 10 ? 10 : self.hours
  end

  def over_time
    self.hours >= 10 ? (self.hours - 10) : 0
  end

  def cost
    (self.straight_time.to_f * self.rate) + (self.over_time.to_f * self.rate * 1.5) + self.per_diem_cost
  end

end
