class GunSheet < ActiveRecord::Base

  belongs_to :job
  belongs_to :equipment
  belongs_to :job_location
  has_many :gun_markings, :dependent => :destroy
  accepts_nested_attributes_for :gun_markings, :reject_if => lambda { |a| a[:amount].blank? }, :allow_destroy => true

end