class Private::WorkOrdersController < ApplicationController

  layout "private"
  filter_access_to :all


  def index
    @page_title = "Work Orders"

    @work_orders = WorkOrder
    # if params[:query].present?
    #   @job_sheets = @work_orders.where('name ilike :query', :query => "%#{params[:query]}%")
    # end
    @work_orders = @work_orders.paginate :page => params[:page], :order => 'work_orders.created_at DESC', :per_page => 50
  end

  def new
    @equipments = Equipment.order("name ASC")
    @work_order = WorkOrder.new
    if params[:equipment_id]
      @equipment = Equipment.find(params[:equipment_id])
      #@work_order.equipment_id = @equipment.id
    end
    @page_title = "New WorkOrder"
  end

  def create
    @page_title = "New WorkOrder"
    @equipment = Equipment.find(params[:work_order][:equipment_id])
    @equipments = Equipment.all
    @work_order = WorkOrder.new(params[:work_order])
    if @work_order.save
      flash[:notice] = "WorkOrder created!"
      redirect_to private_work_orders_url
    else
      render :action => :new
    end
  end

  def show
    @work_order = WorkOrder.find(params[:id])
    @page_title = "WorkOrder Details"

  end

  def generate_report
    @work_order = WorkOrder.find(params[:work_order_id])
    @page_title = "WorkOrder Details"
    output = WorkOrderReport.new.to_pdf(@work_order)
    send_data output, filename: "WorkOrder_#{@work_order.id}.pdf", type: "application/pdf"
  end


end