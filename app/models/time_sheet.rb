class TimeSheet < ActiveRecord::Base

  belongs_to :job
  belongs_to :time_note_category
  belongs_to :created_by, :class_name => "User", :foreign_key => "created_by"
  belongs_to :updated_by, :class_name => "User", :foreign_key => "updated_by"
  has_many :time_tasks, :dependent => :destroy
  has_many :time_entries, :dependent => :destroy
  accepts_nested_attributes_for :time_tasks, :reject_if => lambda { |a| a[:time_task_category_id].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :time_entries, :allow_destroy => true

  def hours
    unless self.completed_at.blank?
      ((self.completed_at.to_time - self.started_at.to_time) / 3600).round(2)
    else
      "Not Marked Complete"
    end
  end

end