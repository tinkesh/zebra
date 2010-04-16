class JobSheet < ActiveRecord::Base

  belongs_to :job
  has_and_belongs_to_many :time_sheets
  has_and_belongs_to_many :gun_sheets

  def label
    "Job Sheet ##{self.id}"
  end

  def date_range
    self.gun_sheets.first.date.to_date.strftime('%b-%d-%y')
  end

  def total_expenses
    self.total_time_cost + self.total_misc_cost + self.total_equipment_cost + self.total_material_cost
  end

  def total_equipment_cost
    total = [0]
    if self.job.equipments.length != 0
      self.job.equipments.each do |equipment|
        total << equipment.cost(self.id)
      end
      total.inject {|sum, n| sum + n.to_f}
    else
      0
    end
  end

  def total_per_diem
    total = [0]
    self.time_sheets.each do |time_sheet|
      time_sheet.time_entries.each do |entry|
        if entry.time_sheet.per_diem == true
          total << entry.time_sheet.per_diem_rate
        else
          total << 0
        end
      end
    end
    total.inject {|sum, n| sum + n.to_f}
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
    self.total_hotel + self.total_fuel
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
        if marking.gun_marking_category_id == category.id : total << marking.amount end
      end
    end
    total.inject {|sum, n| sum + n.to_f}
  end

end