class MaterialReportSummary < ActiveRecord::Base

  belongs_to :job
  has_and_belongs_to_many :gun_sheets
  belongs_to :user

  validates_presence_of :job, :on => :create, :message => "can't be blank"
  validate :unique_set_of_gun_sheets

  def unique_set_of_gun_sheets
    job.material_report_summaries.each do |mrs|
      if gun_sheets == mrs.gun_sheets
        errors.add(:gun_sheets, "An existing report with those gun sheets already exists.")
      end
    end
  end

  def label
    "MRS ##{self.id} with GS ##{self.gun_sheets.collect{|gs| gs.id}.join(',')}"
  end

end
