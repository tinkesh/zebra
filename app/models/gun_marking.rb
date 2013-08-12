class GunMarking < ActiveRecord::Base

  belongs_to :gun_sheet
  belongs_to :gun_marking_category

  validates_numericality_of :amount

  after_initialize do
    self.amount ||= 0 if self.gun_marking_category.present?
  end

end
