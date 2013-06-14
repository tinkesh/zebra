class Estimate < ActiveRecord::Base

  belongs_to :job
  belongs_to :time_sheet

  validates_presence_of :hours
  validates_numericality_of :hours

end
