class Private::CostsController < ApplicationController

  layout "private"
  filter_access_to :all

  def index
    @costs = Cost.order("name ASC")
    @page_title = "Costs"
  end

  def new
    @cost = Cost.new
    @page_title = "New Cost"
  end

  def create
    @cost = Cost.new(params[:cost])
    @page_title = "New Cost"
    if @cost.save
      flash[:notice] = "Cost created!"
      redirect_to private_costs_url
    else
      render :action => :new
    end
  end

  def edit
    @cost = Cost.find(params[:id])
    @page_title = "Edit #{@cost.name}"
  end

  def update
    @cost = Cost.find(params[:id])
    if @cost.update_attributes(params[:cost])
      flash[:notice] = "Cost updated!"
      redirect_to private_costs_url
    else
      render :action => :edit
    end
  end

  def destroy
    @cost = Cost.find(params[:id])
    @cost.destroy
    flash[:notice] = 'Cost deleted!'
    redirect_to private_costs_url
  end

end
