class MaterialReport < ActiveRecord::Base

  belongs_to :job
  has_and_belongs_to_many :load_sheets
  has_and_belongs_to_many :gun_sheets

  def label
    "Material Report ##{self.id}"
  end

end