class TimeEntry < ActiveRecord::Base

  belongs_to :time_sheet
  belongs_to :user

end