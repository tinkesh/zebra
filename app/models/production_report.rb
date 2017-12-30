class ProductionReport < ActiveRecord::Base
=begin
   attr_accessor  :created_by, :created_at, :start_time, :end_time, :completed_by, :report_type,
                   :type_each_1, :type_lm_1, :notes,:parking_lot_line_standard_each,
                   :parking_lot_line_standard_lm ,:parking_lot_line_angle_each,
                   :parking_lot_line_angle_lm,:parking_lot_line_parallel_each,
                   :parking_lot_line_parallel_lm,:cross_hatching_each,:cross_hatching_lm,
                   :crosswalk_line_each,:crosswalk_line_lm,:zebra_bar_crosswalk_lump_sum_each,
                   :zebra_bar_crosswalk_lump_sum_lm,:zebra_bar_each,:zebra_bar_lm,
                   :handicap_symbol_W_blue_back_each,:handicap_symbol_W_blue_back_lm,
                   :handicap_symbol_W_O_blue_back_each,:handicap_symbol_W_O_blue_back_lm,
                   :no_parking_each,:no_parking_lm,:stop_each,:stop_lm,:drive_thru_each,
                   :drive_thru_lm,:stop_bar_each,:stop_bar_lm,:arrow_single_each,:arrow_single_lm,
                   :arrow_double_each,:arrow_double_lm,:speed_bump_regular_each,
                   :speed_bump_regular_lm,:speed_bump_large_each,:speed_bump_large_lm,
                   :parking_stalls_each,:parking_stalls_lm,:sweeping_lump_sum_each,
                   :sweeping_lump_sum_lm,:sweeping_hourly_each,:sweeping_hourly_lm,
                   :scrubbing_lump_sum_each,:scrubbing_lump_sum_lm,:black_out_line_each,
                   :black_out_line_lm,:custom_type1_name,:custom_type1_each,:custom_type1_lm,
                   :custom_type2_name,:custom_type2_each,:custom_type2_lm,:custom_type3_name,
                   :custom_type3_each,:custom_type3_lm,:custom_type4_name,:custom_type4_each,
                   :custom_type4_lm,:custom_type5_name,:custom_type5_each,:custom_type5_lm,
                   :custom_type6_name,:custom_type6_each,:custom_type6_lm
=end


   #belongs_to :created_by, :class_name => "User"
   #belongs_to :completed_by, :class_name => "User"
   belongs_to :job
end
