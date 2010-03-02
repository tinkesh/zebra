class TimeSheet < ActiveRecord::Base

  belongs_to :job
  belongs_to :time_note_category
  has_many :time_tasks, :dependent => :destroy
  has_many :time_entries, :dependent => :destroy
  accepts_nested_attributes_for :time_tasks, :allow_destroy => true
  accepts_nested_attributes_for :time_entries, :allow_destroy => true


end