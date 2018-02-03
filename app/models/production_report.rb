class ProductionReport < ActiveRecord::Base
   belongs_to :job
   belongs_to :completed_user, :class_name => "User"

   def user_completed
    user = User.find(completed_by)
    user.blank? ? "" : user.first_name
   end

   def redable_report_number
     report_number.blank? ? "Production report - 2017" : "Production report - #{report_number}"
   end
end
