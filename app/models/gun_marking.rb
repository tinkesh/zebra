class GunMarking < ActiveRecord::Base

  belongs_to :gun_sheet
  belongs_to :gun_marking_category


end
