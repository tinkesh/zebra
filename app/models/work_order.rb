class WorkOrder < ActiveRecord::Base
  attr_accessible :client_name, :contact_name, :phone, :equipment_id, :user_id, :hour_meter, :odometer, 
                  :date_of_work_completed, :shop_supplies, :labours_attributes, :parts_attributes,
                  :service_performed_notes, :created_date, :completed_date

  belongs_to :equipment
  belongs_to :user

  has_many :labours
  accepts_nested_attributes_for :labours, allow_destroy: true

  has_many :parts
  accepts_nested_attributes_for :parts, allow_destroy: true

  attr_accessor :licence_plate, :serial, :make, :model, :year

  #attr_accessor :service_performed_notes, :created_date, :completed_date

  def labour_cost
  	total_amount = 0
  	labours.each do |l| 
      if l.hourly_rate && l.hours_on_job
        amount = l.hourly_rate * l.hours_on_job
        total_amount = total_amount + amount
      end      
  	end
  	total_amount
  end

  def parts_cost
  	total_amount = 0
  	parts.each do |p|
      if p.quantity && p.unit_rate
        amount = p.quantity * p.unit_rate
        total_amount = total_amount + amount
      end
  	end
  	total_amount
  end

  def total_cost
    labour_cost + parts_cost + shop_supplies
  end

end
