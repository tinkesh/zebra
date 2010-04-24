class Job < ActiveRecord::Base

  versioned

  has_and_belongs_to_many :crews
  belongs_to :client
  belongs_to :completion
  has_many :load_sheets
  has_many :gun_sheets
  has_many :job_sheets
  has_many :job_markings
  has_many :job_locations
  has_many :estimates
  has_many :material_reports
  has_many :time_sheets, :through => :estimates
  has_and_belongs_to_many :time_entries
  has_and_belongs_to_many :equipments
  accepts_nested_attributes_for :time_sheets, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :job_markings, :reject_if => lambda { |a| a[:amount].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :job_locations, :reject_if => lambda { |a| a[:name].blank? },  :allow_destroy => true

  def label
    label = 'Job #' + self.id.to_s
    if self.name : label += ", " + self.name end
    label
  end

end