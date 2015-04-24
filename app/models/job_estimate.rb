class JobEstimate < ActiveRecord::Base
  has_many :estimate_items
  belongs_to :client
  accepts_nested_attributes_for :estimate_items, allow_destroy: true
end
