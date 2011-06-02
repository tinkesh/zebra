class MaterialReport < ActiveRecord::Base

  belongs_to :job
  belongs_to :load_sheet
  belongs_to :gun_sheet

  validates_presence_of :job, :on => :create, :message => "can't be blank"
  validates_presence_of :gun_sheet, :on => :create, :message => "can't be blank"
  validates_presence_of :load_sheet, :on => :create, :message => "can't be blank"

  named_scope :by_equipment, lambda { |equipment_id| { :include => :load_sheet, :conditions => ['load_sheets.equipment_id = ?', equipment_id], :order => "load_sheets.date ASC, material_reports.id ASC"}}

  def label
    "MR ##{self.id} with GS ##{self.gun_sheet_id}, LS ##{self.load_sheet_id}"
  end

  def is_archived?
    self.load_sheet.is_archived? or self.gun_sheet.is_archived?
  end

  def yellow_rate
    self.gun_sheet ? (self.gun_sheet.equipment ? self.gun_sheet.equipment.yellow_rate : 0) : 0
  end

  def white_rate
    self.gun_sheet ? (self.gun_sheet.equipment ? self.gun_sheet.equipment.white_rate : 0) : 0
  end

  def bead_used
    (self.load_sheet.yellow_dip_used + self.load_sheet.white_dip_used) * 0.6
  end

  def next_report
    material_reports = MaterialReport.by_equipment(self.load_sheet.equipment_id)

    pos_in_reports = material_reports.index(self)

    pos_in_reports < material_reports.length ? material_reports[pos_in_reports+1] : nil
  end

  def prev_report
    material_reports = MaterialReport.by_equipment(self.load_sheet.equipment_id)

    pos_in_reports = material_reports.index(self)

    pos_in_reports > 0 ? material_reports[pos_in_reports-1] : nil
  end

end
