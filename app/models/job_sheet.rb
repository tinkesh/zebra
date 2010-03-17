class JobSheet < ActiveRecord::Base

  belongs_to :job
  has_and_belongs_to_many :time_sheets
  has_and_belongs_to_many :gun_sheets


  def total_equipment_cost
    total = []
    self.job.equipments.each do |equipment|
      total << equipment.cost(self.id)
    end
    total.inject {|sum, n| sum + n.to_f}
  end

  def total_per_diem
    total = []
    self.time_sheets.each do |time_sheet|
      time_sheet.time_entries.each do |entry|
        if entry.time_sheet.per_diem == true
          total << entry.time_sheet.per_diem_rate
        end
      end
    end
    total.inject {|sum, n| sum + n.to_f}
  end
  
  def total_straight_time
    total = []
    self.time_sheets.each do |time_sheet|
      time_sheet.time_entries.each do |entry|
        total << entry.straight_time
      end
    end
    total.inject {|sum, n| sum + n.to_f}
  end

  def total_over_time
    total = []
    self.time_sheets.each do |time_sheet|
      time_sheet.time_entries.each do |entry|
        total << entry.over_time
      end
    end
    total.inject {|sum, n| sum + n.to_f}
  end

  def total_hours
    total = []
    self.time_sheets.each do |time_sheet|
      time_sheet.time_entries.each do |entry|
        total << entry.hours
      end
    end
    total.inject {|sum, n| sum + n.to_f}
  end

  def total_cost
    total = []
    self.time_sheets.each do |time_sheet|
      time_sheet.time_entries.each do |entry|
        total << entry.cost
      end
    end
    total.inject {|sum, n| sum + n.to_f}
  end
  
  def total_yellow_paint
    total = []
    self.gun_sheets.each do |gun|
      total << gun.solid_y1 + gun.solid_y2 + gun.solid_y3 + gun.skip_y1 + gun.skip_y2 + gun.skip_y3
    end
    total.inject {|sum, n| sum + n.to_f}
  end

  def total_white_paint
    total = []
    self.gun_sheets.each do |gun|
      total << gun.solid_w4 + gun.solid_w5 + gun.solid_w6 + gun.solid_w7 + gun.skip_w4 + gun.skip_w5 + gun.skip_w6 + gun.skip_w7
    end
    total.inject {|sum, n| sum + n.to_f}
  end
  
  def total_beads
    0
  end

  def total_markings(category)
    total = []
    self.gun_sheets.each do |gun|
      gun.gun_markings.each do |marking|
        if marking.gun_marking_category_id == category.id : total << marking.amount end
      end
    end
    total.inject {|sum, n| sum + n.to_f}
  end

end