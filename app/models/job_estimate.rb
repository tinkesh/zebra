class JobEstimate < ActiveRecord::Base
  has_many :estimate_items
  accepts_nested_attributes_for :estimate_items, allow_destroy: true
end
