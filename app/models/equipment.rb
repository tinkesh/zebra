class Equipment < ActiveRecord::Base

  has_and_belongs_to_many :jobs
  has_many :load_sheets

  validates_presence_of :unit
  validates_presence_of :name
  validates_presence_of :rate

  def cost(job_sheet)
    if self.rate
      @job_sheet = JobSheet.find(job_sheet)
      @job_sheet.time_sheets.length * self.rate
    else
      0
    end
  end

end