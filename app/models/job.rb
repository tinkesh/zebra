class Job < ActiveRecord::Base

  belongs_to :client
  belongs_to :completion
  has_many :time_sheets
  has_many :load_sheets
  has_many :gun_sheets
  has_many :job_markings
  has_and_belongs_to_many :users
  has_and_belongs_to_many :equipments
  has_and_belongs_to_many :locations
  accepts_nested_attributes_for :time_sheets, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :job_markings, :reject_if => lambda { |a| a[:amount].blank? }, :allow_destroy => true

end
