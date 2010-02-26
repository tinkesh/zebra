class Private::LocationsController < ApplicationController

  layout "private"
  # filter_access_to :all, :context => :admin

  def index
    @locations = Location.find(:all, :order => "name ASC")
    @page_title = "Locations"
  end
  
  def new
    @location = Location.new
    @page_title = "New Location"
  end
  
  def create
    @location = Location.new(params[:location])
    if @location.save
      flash[:notice] = "Location created!"
      redirect_back_or_default private_locations_url
    else
      render :action => :new
    end
  end

  def edit
    @location = Location.find(params[:id])
    @page_title = "Edit #{@location.name}"
  end
  
  def update
    @location = Location.find(params[:id])
    if @location.update_attributes(params[:location])
      flash[:notice] = "Location updated!"
      redirect_to private_locations_url
    else
      render :action => :edit
    end
  end

  def destroy
    @location = Location.find(params[:id])
    @location.destroy
    flash[:notice] = 'Location deleted!'
    redirect_to(private_locations_url)
  end

end