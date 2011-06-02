class GunSheet < ActiveRecord::Base

  versioned
  default_scope :order => 'created_at DESC'

  belongs_to :job
  belongs_to :equipment
  belongs_to :job_location
  belongs_to :user, :foreign_key => "created_by"
  has_many :gun_markings, :dependent => :destroy
  has_many :material_reports
  has_and_belongs_to_many :job_sheets
  accepts_nested_attributes_for :gun_markings, :reject_if => lambda { |a| a[:amount].blank? }, :allow_destroy => true
  validates_presence_of [:solid_y1, :solid_y2, :solid_y3, :solid_w4,
                         :solid_w5, :solid_w6, :solid_w7,
                         :skip_y1, :skip_y2, :skip_y3, :skip_w4,
                         :skip_w5, :skip_w6, :skip_w7], :on => :create, :message => "can't be blank"

  after_create :deliver_new_gun_sheet, :verify_actual_vs_expected_production

  def deliver_new_gun_sheet
    Notifier.deliver_new_gun_sheet(self)
  end

  #--------------------------------------------------------------------
  # If the actual is greater than expected, send an email via Notifier
  #
  def verify_actual_vs_expected_production
    job.job_markings.each do |marking|
      puts marking.actual_production
      puts marking.amount
      if marking.actual_production > marking.amount
        Notifier.deliver_job_marking_production_over_expected(marking)
      end
    end
  end

  def label
    "GS ##{self.id}, " + "JOB ##{self.job.id}, " + (self.equipment ? "#{self.equipment.unit}, " : "Unknown, ") + "#{self.started_on.to_date.strftime('%b-%d-%y')}"
  end

  def is_archived?
    Time.parse(self.started_on.to_s) < Job::archive_date
  end

  def yellow_length
    (0 + self.solid_y1 + self.solid_y2 + self.solid_y3 + self.skip_y1 + self.skip_y2 + self.skip_y3) / 1000
  end

  def white_length
    (0 + self.solid_w4 + self.solid_w5 + self.solid_w6 + self.solid_w7 + self.skip_w4 + self.skip_w5 + self.skip_w6 + self.skip_w7) / 1000
  end

  named_scope :created_by_name, lambda {|name| 
    {
      :joins => :user,
      :conditions =>["users.first_name LIKE ?", name]
    }
  }

end
