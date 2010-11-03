class MaterialReport < ActiveRecord::Base

  belongs_to :job
  belongs_to :load_sheet
  belongs_to :gun_sheet

  validates_presence_of :job, :on => :create, :message => "can't be blank"
  validates_presence_of :gun_sheet, :on => :create, :message => "can't be blank"
  validates_presence_of :load_sheet, :on => :create, :message => "can't be blank"

  def label
    "MR ##{self.id} with GS ##{self.gun_sheet_id}, LS ##{self.load_sheet_id}"
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

end