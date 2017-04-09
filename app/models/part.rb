class Part < ActiveRecord::Base
   attr_accessible :name, :description, :quantity, :unit_rate, :work_order_id

   belongs_to :work_order

   validates :name, :description, :quantity, :unit_rate, presence: true

   attr_accessor :total_cost


   def total_price
     quantity*unit_rate
   end

end
