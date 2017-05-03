class MaterialReportPdf < Prawn::Document

  def to_pdf(material_report)

    @material_report = material_report

    logo_path = Rails.root.join('app', 'assets', 'images', 'aaa-striping-logo.png')

    y_position = cursor
    image logo_path, :at => [420, y_position+20]
    move_down 20

    data_header = [[" <font size='26'>MR ##{@material_report.id}</font>"]]
    table(data_header, :header => true,  :width => 520, :cell_style => { :borders => [],:inline_format => true })
    move_down 20

    
    job = ["<b>Job:</b>", "#{@material_report.job.label}",  ""]

    gun_sheet  = [""]
    load_sheet = [""]
    location   = [""]
    created_by = [""]

    if @material_report.gun_sheet
      equipment_name = material_report.gun_sheet.equipment_id ? @material_report.gun_sheet.equipment.name : "Unknown"
      gun_sheet_name = @material_report.gun_sheet.label ? @material_report.gun_sheet.label : "Unknown"
      gun_sheet = ["<b>Gun Sheet:</b>", gun_sheet_name, equipment_name]
    end


    if @material_report.load_sheet
      load_sheet_name_equipment = @material_report.load_sheet.equipment ? @material_report.load_sheet.equipment.name : "Unknown"
      load_sheet_name = @material_report.load_sheet.label ? @material_report.load_sheet.label : "Unknown"
      load_sheet = ["<b>Load Sheet:</b>", load_sheet_name, load_sheet_name_equipment]
    end

    location_name = @material_report.gun_sheet ? @material_report.gun_sheet.location_name : "Unknown"
    location = ["<b>Location:</b>", location_name, ""]


    if @material_report.created_by
      user = User.find_by_id(@material_report.created_by)
      created_by_name = user ? user.name : "Unknown"
    end
    created_by = ["<b>Created By:</b>", created_by_name, ""]

    total_table = [job] + [gun_sheet] + [load_sheet] + [location] + [created_by]
    table( total_table , :width => 520, :cell_style => {:borders => [:bottom], :inline_format => true })
    move_down 40

    tank_yellow_calc = 0
    tank_white_calc  = 0


    if @material_report.load_sheet
      table_header = [[" ", "Tank Start", "Tank End", "Tank Used", "Truck Calculation Rate", "Total Used"]]
      tank_yellow_calc = (@material_report.yellow_rate*@material_report.yellow_dip_used.round(2)).abs
      tank_white_calc  = (@material_report.white_rate*@material_report.white_dip_used.round(2)).abs
      bead_used = ((((tank_white_calc*1) + (tank_yellow_calc*1))* 0.6).round(2)).abs

      table_tr_1   = ["<b>Yellow</b>", @material_report.yellow_dip_start, @material_report.load_sheet.yellow_dip_end, "#{@material_report.yellow_dip_used.abs} cm", "#{@material_report.yellow_rate} L/cm", "#{tank_yellow_calc} L" ]
      table_tr_2   = ["<b>White</b>", @material_report.white_dip_start, @material_report.white_dip_end, "#{@material_report.white_dip_used.abs} cm", "#{@material_report.white_rate} L/cm", "#{tank_white_calc} L" ]
      table_tr_3   = ["<b>Bead</b>", "", "", "", "", "#{bead_used} KG"]
      table_header = table_header + [table_tr_1]+ [table_tr_2]+ [table_tr_3]

      table(table_header, :width => 520, :cell_style => { :align=> :right, :borders => [:bottom], :inline_format => true }) do
        row(0).font_style = :bold
        row(1..3).columns(0).align = :left
      end
      move_down 40
    end

    if @material_report.gun_sheet
      table_header   = [[" ", "Y-1", "Y-2", "Y-3", "W-4", "W-5", "W-6", "W-7"]]

      gun_sheet_tr_1 = ["<b>Solid</b>", @material_report.gun_sheet.solid_y1, @material_report.gun_sheet.solid_y2, @material_report.gun_sheet.solid_y3, @material_report.gun_sheet.solid_w4, @material_report.gun_sheet.solid_w5, @material_report.gun_sheet.solid_w6, @material_report.gun_sheet.solid_w7]
      gun_sheet_tr_2 = ["<b>Skip</b>", @material_report.gun_sheet.skip_y1, @material_report.gun_sheet.skip_y2, @material_report.gun_sheet.skip_y3, @material_report.gun_sheet.skip_w4, @material_report.gun_sheet.skip_w5, @material_report.gun_sheet.skip_w6, @material_report.gun_sheet.skip_w7]
      gun_sheet_tr_3 = ["<b>Total</b>", @material_report.gun_sheet.solid_y1 + @material_report.gun_sheet.skip_y1,
                                 @material_report.gun_sheet.solid_y2 + @material_report.gun_sheet.skip_y2,
                                 @material_report.gun_sheet.solid_y3 + @material_report.gun_sheet.skip_y3,
                                 @material_report.gun_sheet.solid_w4 + @material_report.gun_sheet.skip_w4,
                                 @material_report.gun_sheet.solid_w5 + @material_report.gun_sheet.skip_w5,
                                 @material_report.gun_sheet.solid_w6 + @material_report.gun_sheet.skip_w6,
                                 @material_report.gun_sheet.solid_w7 + @material_report.gun_sheet.skip_w7]
      table_header = table_header + [gun_sheet_tr_1]+ [gun_sheet_tr_2] + [gun_sheet_tr_3]
      table(table_header, :width => 520, :cell_style => { :align=> :right, :borders => [:bottom], :inline_format => true }) do 
        row(0).font_style = :bold
        row(1..3).columns(0).align = :left
      end
      move_down 40
    end

    table_header = [[" ", "Total Used", "Solid+Skip Line KM", "Used/Line KM", "Target"]]
    
    summary_yellow_length      = @material_report.gun_sheet ? @material_report.gun_sheet.yellow_length : 0

    yellow_used_line           = summary_yellow_length != 0 ? (tank_yellow_calc/summary_yellow_length).round(2) : 0
    
    summary_total_yellow_used  = tank_yellow_calc
    summary_yellow_calculation = summary_yellow_length != 0 ?  (summary_total_yellow_used / summary_yellow_length).round(3) : 0
    table_3_tr_1 = ["<b>Yellow</b>", "#{tank_yellow_calc} L", summary_yellow_length, summary_yellow_calculation, "38 L/KM"]
    
    summary_total_white_used   = tank_white_calc
    summary_white_length       = @material_report.gun_sheet ? @material_report.gun_sheet.white_length : 0
    summary_white_calculation  = summary_yellow_length != 0 ? (summary_total_white_used / summary_white_length).round(3) : 0
    table_3_tr_2 = ["<b>White</b>", "#{tank_white_calc} L", summary_white_length, summary_white_calculation, "38 L/KM"]
    
    summary_bead_used          = (((summary_total_yellow_used*1) + (summary_total_white_used*1))*0.6).round(2)
    summary_bead_length        = ((summary_yellow_length*1)+(summary_white_length*1)).round(2)
    summary_bead_calculation   = (summary_bead_used / summary_bead_length).round(2)
    table_3_tr_3 = ["<b>Bead</b>", "#{summary_bead_used} KG", summary_bead_length, summary_bead_calculation, "22.2 KG/KM"]

    table_header = table_header + [table_3_tr_1]+ [table_3_tr_2] + [table_3_tr_3]
    table(table_header, :width => 520, :cell_style => { :align=> :right, :borders => [:bottom], :inline_format => true }) do 
      row(0).font_style = :bold
      row(1..3).columns(0).align = :left
    end
    move_down 60

    if @material_report.gun_sheet
      table_header  = [["<b>Production</b>", "<b>Amount</b>"]]
      interchanges  = @material_report.gun_sheet.interchanges.blank? ? "0" : @material_report.gun_sheet.interchanges
      table_4_tr_1  = ["Interchanges", interchanges]
      
      intersections = @material_report.gun_sheet.sides.blank? ? "0" : @material_report.gun_sheet.sides
      table_4_tr_2  = ["Intersections", intersections]

      table_header = table_header + [table_4_tr_1] + [table_4_tr_2]

      @material_report.gun_sheet.gun_markings.each do |marking|
        ma = marking.gun_marking_category.name rescue "Unknown Category"
        tr = [ma, marking.amount]
        table_header = table_header + [tr]
      end
      table(table_header, :width => 520, :cell_style => { :borders => [:bottom], :inline_format => true })
      move_down 20
    end

    if @material_report.comments.present?
      table_header  = [["<b>Comments</b>"]]
      table_header = table_header + [[@material_report.comments]]
      table(table_header, :width => 520, :cell_style => { :borders => [:bottom], :inline_format => true })
      move_down 20
    end

    if @material_report.load_sheet
      load_entries = @material_report.load_sheet.load_entries
      if @material_report.load_sheet.present? && load_entries.present?
        table_header  = [["<b>Batch #<b>"]]
        load_entries.each do |entry|
          table_header = table_header + [[entry.material.try(:batch)]]
        end
        table(table_header, :width => 520, :cell_style => { :borders => [:bottom], :inline_format => true })
        move_down 20
      end
    end


    render
  end

end
