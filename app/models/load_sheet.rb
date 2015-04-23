class LoadSheet < ActiveRecord::Base
  default_scope :order => 'load_sheets.created_at DESC'

  belongs_to :job
  belongs_to :equipment
  belongs_to :daily_report
  has_many :load_entries, :dependent => :destroy
  has_many :material_reports
  accepts_nested_attributes_for :load_entries, :reject_if => lambda { |a| a[:material_id].blank? }, :allow_destroy => true

  validates_presence_of :date, :yellow_dip_end, :yellow_dip_start, :white_dip_end, :white_dip_start
  #validates_presence_of :equipment_id
  validates_numericality_of :yellow_dip_end, :yellow_dip_start, :white_dip_end, :white_dip_start

  after_create :deliver_new_load_sheet
  after_create :update_adjusted_dips

  def deliver_new_load_sheet
    SiteMailer.new_load_sheet(self).deliver
  end

  def label
    retval = "LS ##{self.id}, "
    retval << "JOB ##{self.job.id}, " if self.job
    retval << (self.equipment.unit rescue 'Unknown') + ', '
    retval << "#{self.date.to_date.strftime('%b-%d-%y') rescue ''}"
  end

  def is_archived?
    Time.zone.parse(self.date.to_s) < Job::archive_date
  end

  def yellow_dip_used
    (self.yellow_dip_end - self.yellow_dip_start) rescue 0
  end

  def white_dip_used
    (self.white_dip_end - self.white_dip_start) rescue 0
  end

  def adjusted_yellow_dip_used
    self.adjusted_yellow_dip_end - self.adjusted_yellow_dip_start
  end

  def adjusted_white_dip_used
    self.adjusted_white_dip_end - self.adjusted_white_dip_start
  end

  # These next 4 printable methods are used by Material Reports#show
  def printable_white_dip_start
    self.adjusted_white_dip_start || self.white_dip_start
  end

  def printable_white_dip_end
    self.adjusted_white_dip_end || self.white_dip_end
  end

  def printable_yellow_dip_start
    self.adjusted_yellow_dip_start || self.yellow_dip_start
  end

  def printable_yellow_dip_end
    self.adjusted_yellow_dip_end || self.yellow_dip_end
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
