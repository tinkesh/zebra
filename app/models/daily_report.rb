class DailyReport < ActiveRecord::Base
  belongs_to :user
  has_many :load_sheets
  has_many :gun_sheets

  # loaded
  # painted

  attr_accessible :user_id, :loaded, :painted


end
