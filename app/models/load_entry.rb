class LoadEntry < ActiveRecord::Base

  belongs_to :load_sheet
  belongs_to :material


  def amount
    self.tote_quantity * self.material.manufacturer.amount
  end

end