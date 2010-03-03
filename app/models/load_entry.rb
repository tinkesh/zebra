class LoadEntry < ActiveRecord::Base

  belongs_to :load_sheet
  belongs_to :material

end