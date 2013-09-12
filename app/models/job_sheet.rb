class JobSheet < ActiveRecord::Base

  belongs_to :job
  has_and_belongs_to_many :time_sheets
  has_and_belongs_to_many :gun_sheets

  validates_presence_of :material_rate, :job_id, :message => "can't be blank"

  def label
    ret_val = "Job Sheet ##{self.id}, "

    if self.gun_sheets.first && self.gun_sheets.first.started_on
      ret_val << self.gun_sheets.first.started_on.to_date.strftime('%b-%d-%y')
    else
      if self.date.present?
        ret_val << self.date.strftime('%b-%d-%y')
      else
        ret_val << "No Date"
      end
    end
  end

  def date_range
    self.gun_sheets.first.started_on.to_date.strftime('%b-%d-%y') if self.gun_sheets.first && self.gun_sheets.first.started_on
  end

  def is_archived?
    if self.gun_sheets && self.gun_sheets.first
      archive_date = Time.zone.parse(self.gun_sheets.first.started_on.to_s)
    else
      archive_date = self.created_at
    end

    archive_date < Job::archive_date
  end

  def net
    self.total_marking_earnings - self.total_expenses
  end

  def total_expenses
    0 + self.total_misc_cost + self.total_equipment_cost + self.total_material_cost
  end

  def total_equipment_cost
    total_cost = 0

    self.gun_sheets.each do |sheet|
      if sheet.equipment
        total_cost = total_cost + (sheet.equipment.rate * self.time_sheets.length)
      end
    end

    total_cost
  end

  def total_per_diem
    total = [0]
    self.time_sheets.each do |time_sheet|
      if time_sheet.per_diem_percent != 0
        total << (time_sheet.per_diem_percent * time_sheet.time_entries.length)
      end
    end
    total.inject {|sum, n| sum + n.to_f}
  end

  def total_per_diem_cost
    self.total_per_diem * Cost.find_by_name('per diem').value.to_i
  end

  def total_straight_time
    total = [0]
    self.time_sheets.each do |time_sheet|
      time_sheet.time_entries.each do |entry|
        total << entry.straight_time
      end
    end
    total.inject {|sum, n| sum + n.to_f}
  end

  def total_over_time
    total = [0]
    self.time_sheets.each do |time_sheet|
      time_sheet.time_entries.each do |entry|
        total << entry.over_time
      end
    end
    total.inject {|sum, n| sum + n.to_f}
  end

  def total_lunch_time
    total = [0]
    self.time_sheets.each do |time_sheet|
      time_sheet.time_entries.each do |entry|
        total << entry.time_sheet.lunch
      end
    end
    total.inject {|sum, n| sum + n.to_f} / 60
  end

  def total_hours
    total = [0]
    self.time_sheets.each do |time_sheet|
      time_sheet.time_entries.each do |entry|
        total << entry.hours
      end
    end
    total.inject {|sum, n| sum + n.to_f}
  end

  def total_hotel
    total = [0]
    self.time_sheets.each do |time_sheet|
      total << time_sheet.hotel
    end
    total.inject {|sum, n| sum + n.to_f}
  end

  def total_fuel
    total = [0]
    self.time_sheets.each do |time_sheet|
      total << time_sheet.fuel_cost
    end
    total.inject {|sum, n| sum + n.to_f}
  end

  def total_misc_cost
    self.total_hotel + self.total_fuel + self.total_per_diem_cost
  end

  def marking_earnings(marking)
    0 + self.total_markings(marking.gun_marking_category) * marking.rate
  end

  def total_marking_earnings
    total = [0]
    self.job.job_markings.each do |marking|
      total << (self.total_markings(marking.gun_marking_category) * marking.rate)
    end
    total.inject {|sum, n| sum + n.to_f}
  end

  def total_time_cost
    total = [0]
    self.time_sheets.each do |time_sheet|
      time_sheet.time_entries.each do |entry|
        total << entry.cost
      end
    end
    total.inject {|sum, n| sum + n.to_f}
  end

  def total_yellow_paint
    if self.gun_sheets.length != 0
      total = [0]
      self.gun_sheets.each do |gun|
        total << gun.solid_y1 + gun.solid_y2 + gun.solid_y3 + gun.skip_y1 + gun.skip_y2 + gun.skip_y3
      end
      total.inject {|sum, n| sum + n.to_f}
    else
      0
    end
  end

  def total_white_paint
    if self.gun_sheets.length != 0
      total = [0]
      self.gun_sheets.each do |gun|
        total << gun.solid_w4 + gun.solid_w5 + gun.solid_w6 + gun.solid_w7 + gun.skip_w4 + gun.skip_w5 + gun.skip_w6 + gun.skip_w7
      end
      total.inject {|sum, n| sum + n.to_f}
    else
      0
    end
  end

  def total_white_paint_usage
    self.total_white_paint * 0.0382
  end

  def total_white_paint_cost
    self.total_white_paint_usage * self.material_rate
  end

  def total_yellow_paint_usage
    self.total_yellow_paint * 0.0382
  end

  def total_yellow_paint_cost
    self.total_yellow_paint_usage * self.material_rate
  end

  def total_bead_distance
    self.total_white_paint + self.total_yellow_paint
  end

  def total_bead
    self.total_bead_distance * 0.0006
  end

  def total_bead_cost
    self.total_bead * 0.48
  end

  def total_material_cost
    self.total_white_paint_cost + self.total_yellow_paint_cost + self.total_bead_cost
  end

  def total_markings(category)
    total = [0]
    self.gun_sheets.each do |gun|
      gun.gun_markings.each do |marking|
        total << marking.amount if marking.gun_marking_category_id == category.try(:id)
      end
    end
    total.inject {|sum, n| sum + n.to_f}
  end

end
