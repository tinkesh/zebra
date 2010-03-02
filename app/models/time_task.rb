class TimeTask < ActiveRecord::Base

  belongs_to :time_sheet
  belongs_to :time_task_category
#  validates_presence_of :time_task_category, :on => :create, :message => "can't be blank"
#  validates_presence_of :time, :on => :create, :message => "can't be blank"

end