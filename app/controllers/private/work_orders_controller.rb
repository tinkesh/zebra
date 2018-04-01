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
    @page_title = "New Work Order"
  end

  def create
    if params[:work_order][:assets_attributes][0]["image"].blank? 
      params[:work_order].except!(:assets_attributes)
    end

    @page_title = "New Work Order"
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
    @page_title = "Work Order Details"

  end

  def edit
    @work_order = WorkOrder.find(params[:id])
    @page_title = "Edit #{@work_order.id}"
    @equipment = Equipment.find(@work_order.equipment_id)
    @equipments = Equipment.all
  end

  def update
    @work_order = WorkOrder.find(params[:id])

    if params[:work_order][:assets_attributes] && params[:work_order][:assets_attributes][0]["image"].blank? 
      params[:work_order].except!(:assets_attributes)
    end

    if @work_order.update_attributes(params[:work_order])
      redirect_to private_work_order_path(@work_order) and return 
    else
      @page_title = "Edit #{@work_order.id}"
      @equipment = Equipment.find(@work_order.equipment_id)
      @equipments = Equipment.all
      render :action => :edit
    end
  end


  def generate_report
    @work_order = WorkOrder.find(params[:work_order_id])
    @page_title = "Work Order Details"
    output = WorkOrderReport.new.to_pdf(@work_order)
    send_data output, filename: "WorkOrder_#{@work_order.id}.pdf", type: "application/pdf"
  end


  def destroy
    @work_order = WorkOrder.find(params[:id])
    @work_order.destroy
    flash[:notice] = 'WorkOrder deleted!'
    redirect_to(private_work_orders_url)
  end

  def delete_document
    @work_order = WorkOrder.find(params[:id])
    document = @work_order.assets.find(params[:asset_id])
    document.destroy

    flash[:notice] = 'WorkOrder document deleted!'
    redirect_to  private_work_order_path(@work_order)
  end


end
