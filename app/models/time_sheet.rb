class TimeSheet < ActiveRecord::Base

  belongs_to :job
  belongs_to :time_note_category
  belongs_to :created_by, :class_name => "User", :foreign_key => "created_by"
  belongs_to :updated_by, :class_name => "User", :foreign_key => "updated_by"
  has_many :time_tasks, :dependent => :destroy
  has_many :time_entries, :dependent => :destroy
  has_and_belongs_to_many :job_sheets
  accepts_nested_attributes_for :time_tasks, :reject_if => lambda { |a| a[:time_task_category_id].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :time_entries, :allow_destroy => true

  validates_presence_of :lunch, :on => :create, :message => "can't be blank"
  validates_presence_of :per_diem, :on => :create, :message => "can't be blank"

  before_create :record_per_diem_rate

  def hours
    unless self.completed_at.blank?
      ((self.completed_at.to_time - self.started_at.to_time - (self.lunch * 60)) / 3600).round(2)
    else
      "Not Marked Complete"
    end
  end

  def record_per_diem_rate
    @rate = Cost.find(:first, :conditions => {:name => "per diem"})
    self.per_diem_rate = @rate.value
  end

end