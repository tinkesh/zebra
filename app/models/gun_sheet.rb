class GunSheet < ActiveRecord::Base

  versioned

  belongs_to :job
  belongs_to :equipment
  belongs_to :job_location
  has_many :gun_markings, :dependent => :destroy
  has_many :material_reports
  has_and_belongs_to_many :job_sheets
  accepts_nested_attributes_for :gun_markings, :reject_if => lambda { |a| a[:amount].blank? }, :allow_destroy => true
  validates_presence_of [:solid_y1, :solid_y2, :solid_y3, :solid_w4,
                         :solid_w5, :solid_w6, :solid_w7,
                         :skip_y1, :skip_y2, :skip_y3, :skip_w4,
                         :skip_w5, :skip_w6, :skip_w7], :on => :create, :message => "can't be blank"

  after_create :deliver_new_gun_sheet


   def deliver_new_gun_sheet
    Notifier.deliver_new_gun_sheet(self)
  end

  def label
    "Gun Sheet ##{self.id} #{self.started_on.to_date.strftime('%b-%d-%y')}"
  end

  def yellow_length
    0 + self.solid_y1 + self.solid_y2 + self.solid_y3 + self.skip_y1 + self.skip_y2 + self.skip_y3
  end

  def white_length
    0 + self.solid_w4 + self.solid_w5 + self.solid_w6 + self.solid_w7 + self.skip_w4 + self.skip_w5 + self.skip_w6 + self.skip_w7
  end

end