class Estimate < ActiveRecord::Base

  belongs_to :job
  belongs_to :time_sheet

end