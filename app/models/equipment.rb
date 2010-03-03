class Equipment < ActiveRecord::Base

  has_and_belongs_to_many :jobs
  has_many :load_sheets

end
