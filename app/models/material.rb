class Material < ActiveRecord::Base

  belongs_to :manufacturer
  has_many :load_entries

end
