class MaterialReport < ActiveRecord::Base

  belongs_to :job
  belongs_to :load_sheet
  belongs_to :gun_sheet

  validates_presence_of :job, :on => :create, :message => "can't be blank"
  validates_presence_of :gun_sheet, :on => :create, :message => "can't be blank"
  validates_presence_of :load_sheet, :on => :create, :message => "can't be blank"

  def label
    "Material Report ##{self.id}"
  end

  def yellow_rate
    if self.gun_sheet
      if self.gun_sheet.equipment
        self.gun_sheet.equipment.yellow_rate
      else
        0
      end
    else
      0
    end
  end

  def white_rate
    if self.gun_sheet
      if self.gun_sheet.equipment
        self.gun_sheet.equipment.white_rate
      else
        0
      end
    else
      0
    end
  end

end