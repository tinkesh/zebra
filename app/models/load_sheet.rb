class LoadSheet < ActiveRecord::Base

  versioned
  default_scope :order => 'created_at DESC'

  belongs_to :job
  belongs_to :equipment
  has_many :load_entries, :dependent => :destroy
  has_many :material_reports
  accepts_nested_attributes_for :load_entries, :reject_if => lambda { |a| a[:material_id].blank? }, :allow_destroy => true

  after_create :deliver_new_load_sheet
  after_create :update_adjusted_dips

  def deliver_new_load_sheet
    Notifier.deliver_new_load_sheet(self)
  end

  def label
    "LS ##{self.id}, " + (self.equipment ? "#{self.equipment.unit}, " : "Unknown, ") + "#{self.date.to_date.strftime('%b-%d-%y')}"
  end

  def yellow_dip_used
    !(self.yellow_dip_end.blank? || self.yellow_dip_start.blank?) ? self.yellow_dip_end - self.yellow_dip_start : 0
  end

  def white_dip_used
    !(self.white_dip_end.blank? || self.white_dip_start.blank?) ? self.white_dip_end - self.white_dip_start : 0
  end

  def adjusted_yellow_dip_used
    self.adjusted_yellow_dip_end - self.adjusted_yellow_dip_start
  end

  def adjusted_white_dip_used
    self.adjusted_white_dip_end - self.adjusted_white_dip_start
  end

private

  def update_adjusted_dips
    self.update_attributes(
      :adjusted_yellow_dip_end => self.yellow_dip_end,
      :adjusted_yellow_dip_start => self.yellow_dip_start,
      :adjusted_white_dip_end => self.white_dip_end,
      :adjusted_white_dip_start => self.white_dip_start)
  end

end