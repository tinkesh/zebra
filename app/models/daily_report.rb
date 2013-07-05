class DailyReport < ActiveRecord::Base
  belongs_to :user

  # loaded
  # painted

  attr_accessible :user_id, :loaded, :painted


end
