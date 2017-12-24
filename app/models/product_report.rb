class ProductReport < ActiveRecord::Base

   attr_accessor  :created_by, :created_at, :start_time, :end_time, :completed_by, :report_type,
                   :type_each_1, :type_lm_1, :notes
end
