class EstimateItem < ActiveRecord::Base
  belongs_to :job_estimate

  validates :title, :quantity, :price, presence: true
end
