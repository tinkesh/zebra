class Labour < ActiveRecord::Base
  attr_accessible :mechanic_name, :hours_on_job, :hourly_rate, :work_order_id

  belongs_to :work_order

  #validates :mechanic_name, :hours_on_job, :hourly_rate, presence: true


  def sub_total
  	hours_on_job*hourly_rate
  end

end
