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

  before_create :record_per_diem_rate
  before_create :record_fuel_rate

  def total_per_diem
    total = [0]
    if self.per_diem == true
      self.time_entries.each do |entry|
        total << entry.time_sheet.per_diem_rate
      end
    end
    total.inject {|sum, n| sum + n.to_f}
  end

  def total_straight_time
    total = [0]
    self.time_entries.each do |entry|
      total << entry.straight_time
    end
    total.inject {|sum, n| sum + n.to_f}
  end

  def total_over_time
    total = [0]
    self.time_entries.each do |entry|
      total << entry.over_time
    end
    total.inject {|sum, n| sum + n.to_f}
  end

  def total_lunch_time
    total = [0]
    self.time_entries.each do |entry|
      total << entry.time_sheet.lunch
    end
    total.inject {|sum, n| sum + n.to_f} / 60
  end

  def total_hours
    total = [0]
    self.time_entries.each do |entry|
      total << entry.hours
    end
    total.inject {|sum, n| sum + n.to_f}
  end

  def record_per_diem_rate
    @rate = Cost.find(:first, :conditions => {:name => "per diem"})
    if @rate : self.per_diem_rate = @rate.value else self.fuel_rate = "30" end
  end

  def record_fuel_rate
    @rate = Cost.find(:first, :conditions => {:name => "fuel"})
    if @rate : self.fuel_rate = @rate.value else self.fuel_rate = "0.90" end
  end

  def fuel_cost
    self.fuel * self.fuel_rate
  end

end