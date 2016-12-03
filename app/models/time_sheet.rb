class TimeSheet < ActiveRecord::Base
  serialize :questions, Hash

  belongs_to :time_note_category
  belongs_to :user, :foreign_key => 'created_by'
  has_many :time_tasks, :dependent => :destroy
  has_many :time_entries, :dependent => :destroy
  has_many :estimates, :dependent => :destroy
  has_many :jobs, :through => :estimates
  has_and_belongs_to_many :job_sheets
  accepts_nested_attributes_for :time_tasks, :reject_if => lambda { |a| a[:time_task_category_id].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :time_entries, :allow_destroy => true

  validates_presence_of :lunch, :on => :create, :message => "can't be blank"
  validates_presence_of :hotel, :fuel
  validates_numericality_of :hotel, :fuel

  before_create :record_per_diem_rate
  before_create :record_fuel_rate
  after_create :deliver_new_time_sheet

  QUESTIONS = {
    # make sure hash keys are unique, and don't change them! They're saved in each instance
    :travel => 'Did you travel?',
    :load => 'Did you Load?',
    :paint => 'Did you Paint?',
    :line_removal => 'Was there Line Removal?',
    :message_markings => 'Were there Message Markings?',
    :other => 'Other'
  }

  QUESTIONS_DEFAULT_VALUE = {
    # make sure hash keys are unique, and don't change them! They're saved in each instance
    :travel => 'no',
    :load => 'yes',
    :paint => 'yes',
    :line_removal => 'no',
    :message_markings => 'no',
    :other => 'no'
  }

  #This was removed as part of client request
  # validate do
  #   QUESTIONS.each_pair do |key, value|
  #     self.questions[key] ||= {}
  #     if self.questions[key]['answer'].blank?
  #       self.errors.add :base, "Please answer <strong>#{value}</strong>"
  #     end
  #   end
  # end

  def deliver_new_time_sheet
    SiteMailer.new_time_sheet(self).deliver
  end

  def questions
    self[:questions] || {}
  end

  def check_hours_of_user_time(entries)
    total_time = 0
    today_time = 0

    # dana - was written 'if entries' but that was causing a nil error on nil.user_id
    if entries.length != 0
      user = User.find(entries[0].user_id)
      name = user.first_name + ' ' + user.last_name

      entries.each do |ent|
        total_time += ent.straight_time
        total_time += ent.over_time
        if ent.time_sheet_id.eql?(self.id)
          today_time = (ent.straight_time + ent.over_time)
          if today_time >= 15
            SiteMailer.time_sheet_over_hours(self,today_time,name).deliver
          end
        end
      end

    end

    if total_time  >= 160 || total_time  >= 215 || total_time  >= 230 || total_time  >= 250
      SiteMailer.time_sheet_many_hours(self,total_time,name).deliver
    end
  end

  def label
    ret_val = "Time Sheet ##{self.id}, "

    if self.time_entries && self.time_entries.first
      ret_val << self.time_entries.first.clock_in.strftime('%b-%d-%y')
    else
      ret_val << self.created_at.strftime('%b-%d-%y')
    end
  end

  def is_archived?
    if self.time_entries && self.time_entries.first
      archive_date = self.time_entries.first.clock_in
    else
      archive_date = self.created_at
    end

    archive_date < Job::archive_date
  end

  def total_per_diem
    begin
      self.per_diem_percent != 0 ? (self.per_diem_percent * self.time_entries.length) : 0
    rescue
      0
    end
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
    @rate = Cost.where(:name => "per diem").first
    if @rate
      self.per_diem_rate = @rate.value
    else
      self.fuel_rate = "30"
    end
  end

  def record_fuel_rate
    @rate = Cost.where(:name => "fuel").first
    if @rate
      self.fuel_rate = @rate.value
    else
      self.fuel_rate = "0.90"
    end
  end

  def fuel_cost
    self.fuel * self.fuel_rate
  end

end
