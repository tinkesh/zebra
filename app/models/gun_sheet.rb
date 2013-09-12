class GunSheet < ActiveRecord::Base
  default_scope :order => 'gun_sheets.created_at DESC'

  belongs_to :job
  belongs_to :equipment
  belongs_to :daily_report
  belongs_to :job_location
  belongs_to :user, :foreign_key => "created_by"
  has_many :gun_markings, :dependent => :destroy
  has_many :material_reports
  has_and_belongs_to_many :job_sheets
  accepts_nested_attributes_for :gun_markings, :reject_if => lambda { |a| a[:gun_marking_category_id].blank? }, :allow_destroy => true
  validates_presence_of [:solid_y1, :solid_y2, :solid_y3, :solid_w4,
                         :solid_w5, :solid_w6, :solid_w7,
                         :skip_y1, :skip_y2, :skip_y3, :skip_w4,
                         :skip_w5, :skip_w6, :skip_w7], :on => :create, :message => "can't be blank"

  validates_presence_of :started_on, :completed_on

  after_create :deliver_new_gun_sheet, :verify_actual_vs_expected_production


  scope :created_by_name, lambda { |name| joins(:user).where("users.first_name LIKE ?", name) }

  def deliver_new_gun_sheet
    SiteMailer.new_gun_sheet(self).deliver
  end

  #--------------------------------------------------------------------
  # If the actual is greater than expected, send an email via Notifier
  #
  def verify_actual_vs_expected_production
    job.job_markings.each do |marking|
      puts marking.actual_production
      puts marking.amount
      if marking.actual_production > marking.amount
        SiteMailer.job_marking_production_over_expected(marking).deliver
      end
    end
  end

  def label
    "GS ##{self.id}, " + "JOB ##{self.job.try(:id)}, " + (self.equipment ? "#{self.equipment.try(:unit)}, " : "Unknown, ") + "#{self.started_on.try(:to_date).try(:strftime, '%b-%d-%y')}"
  end

  def is_archived?
    Time.zone.parse(self.started_on.to_s) < Job::archive_date
  end

  def yellow_length
    (0 + self.solid_y1 + self.solid_y2 + self.solid_y3 + self.skip_y1 + self.skip_y2 + self.skip_y3) / 1000
  end

  def white_length
    (0 + self.solid_w4 + self.solid_w5 + self.solid_w6 + self.solid_w7 + self.skip_w4 + self.skip_w5 + self.skip_w6 + self.skip_w7) / 1000
  end

  def set_guns_to_zero
    self.solid_y1 = 0
    self.solid_y2 = 0
    self.solid_y3 = 0
    self.solid_w4 = 0
    self.solid_w5 = 0
    self.solid_w6 = 0
    self.solid_w7 = 0
    self.skip_y1 = 0
    self.skip_y2 = 0
    self.skip_y3 = 0
    self.skip_w4 = 0
    self.skip_w5 = 0
    self.skip_w6 = 0
    self.skip_w7 = 0
  end

end
