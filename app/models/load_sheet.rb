class LoadSheet < ActiveRecord::Base

  belongs_to :job
  belongs_to :equipment
  has_many :load_entries, :dependent => :destroy
  accepts_nested_attributes_for :load_entries, :reject_if => lambda { |a| a[:material_id].blank? }, :allow_destroy => true

end