class GunSheet < ActiveRecord::Base

  belongs_to :job
  belongs_to :equipment
  belongs_to :job_location
  has_many :gun_markings, :dependent => :destroy
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
    "Gun Sheet ##{self.id} #{self.date.to_date.strftime('%b-%d-%y')}"
  end

end