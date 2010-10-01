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
    33.97
  end

  def white_rate
    33.97
  end

end