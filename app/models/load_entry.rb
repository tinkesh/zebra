class LoadEntry < ActiveRecord::Base

  belongs_to :load_sheet
  belongs_to :material


  def amount
    if self.material && self.material.manufacturer
      self.tote_quantity * self.material.manufacturer.amount
    else
      0
    end
  end

end