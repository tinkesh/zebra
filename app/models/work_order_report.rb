class WorkOrderReport < Prawn::Document

  def to_pdf(workorder)
    @work_order = workorder
    logo_path = Rails.root.join('app', 'assets', 'images', 'aaa-striping-logo.png')

    # data_header = [["WorkOrder: #{@work_order.id}"]]
    # table(data_header, :header => true,  :width => 520)
    # move_down 20
    #logo
    #table_header = [[{:image => logo_path}]]
    #table(table_header, :width => 520, :position => :right)
    y_position = cursor
    image logo_path, :at => [420, y_position+20]
    move_down 20

    text_box "Shop Repair Work Order", :at => [120, y_position+20], :size => 22

    move_down 70
    #new_position = cursor
    #text_box "<b>ZebraOnline</b>", :at => [440, new_position], :size => 10, :inline_format => true
    
    new_position = cursor
    draw_text "ZebraOnline", :at => [440, new_position], :inline_format => true
    move_down 10

    work_order_id = "Wo No: #{@work_order.id}"
    if !@work_order.created_date.blank?
     created_date_content = @work_order.created_date.strftime('%b-%d-%y')
    else
     created_date_content = " "
    end
    created_date = make_cell(:content => "Date: #{created_date_content}")

    client_name = make_cell(:content => "Client Name: #{@work_order.client_name}")
    phone = make_cell(:content => "Phone # #{@work_order.phone}")
    contact_name = make_cell(:content => "Contact Name: # #{@work_order.contact_name}")
    
    table( [ [work_order_id], [created_date], [client_name], [phone], [contact_name] ] , :width => 520)
    
    equipment_info = [["Unit: #{@work_order.equipment.name if !@work_order.equipment.blank?}",
                       "Hour meter: #{@work_order.hour_meter}",
                       "Odometer: #{@work_order.odometer}"]]
    table(equipment_info, :width => 520 )

    equipment_info_1 = [["Licence Plate #: #{@work_order.equipment.plate_number if !@work_order.equipment.blank?}",
                         "Serial #: #{@work_order.equipment.id if !@work_order.equipment.blank? }"]]
    table(equipment_info_1, :width => 520 )


    equipment_info_2 = [["Make: #{@work_order.equipment.equipment_make if !@work_order.equipment.blank?}",
                       "Model: #{@work_order.equipment.equipment_model if !@work_order.equipment.blank?}",
                       "Year: #{@work_order.equipment.equipment_year if !@work_order.equipment.blank?}"]]
    table(equipment_info_2, :width => 520 )

    total_cost = [["Total Cost: $ #{@work_order.total_cost} + 5% GST"]] 
    table(total_cost, :width => 520 )

    date_completed = [["Date Work Completed: #{@work_order.completed_date.strftime('%b-%d-%y') if !@work_order.completed_date.blank?}"]] 
    table(date_completed, :width => 520 )
    move_down 20


    #parts section
    text "Parts"
    table_header = [["Quantity", "Part No. ", "Discription", "Unit Rate", "Total Price"]]
    @work_order.parts.each do |part|
      part_details = [part.quantity,part.name, part.description, "$#{part.unit_rate}", "$#{part.total_price}"  ]
      table_header = table_header + [part_details]
    end
    #table_header = table_header + [[{:content => "Total Parts", :colspan => 4} , 1234]]
    table_header = table_header + [["", "", "", "Total Parts", "$#{@work_order.parts_cost}"]]
    table(table_header, :width => 520)
    move_down 20

    text "Services Perfromed & Notes :"
    text "#{@work_order.service_performed_notes}"
    move_down 20

    #labour
    text "Labour & Shop Supplies"
    table_header = [["Mechanic Name", "Hours On Job", "Rate/Hr", "Sub Total"]]
    @work_order.labours.each do |labour|
      labour_details = [labour.mechanic_name,labour.hours_on_job, "$#{labour.hourly_rate}", "$#{labour.sub_total}"  ]
      table_header = table_header + [labour_details]
    end
    table_header = table_header + [["", "", "Shop Supplies", "$#{@work_order.shop_supplies}"]]
    table_header = table_header + [["", "", "Total Labour & Shop Supplies", "$#{@work_order.labour_cost + @work_order.shop_supplies}"]]
    table(table_header, :width => 520)
    move_down 40


    text "Name:     ________________________________________"
    move_down 20
    text "Signature:________________________________________ "
    move_down 10


    render
  end

end
