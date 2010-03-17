class GunSheet < ActiveRecord::Base

  belongs_to :job
  belongs_to :equipment
  belongs_to :job_location
  has_many :gun_markings, :dependent => :destroy
  has_and_belongs_to_many :job_sheets
  accepts_nested_attributes_for :gun_markings, :reject_if => lambda { |a| a[:amount].blank? }, :allow_destroy => true
  validates_presence_of [:solid_y1, :solid_y2, :solid_y3, :solid_y4, 
                         :solid_w5, :solid_w6, :solid_w7, 
                         :skip_y1, :skip_y2, :skip_y3, :skip_y4, 
                         :skip_w5, :skip_w6, :skip_w7], :on => :create, :message => "can't be blank"

end