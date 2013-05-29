class Private::ManufacturersController < ApplicationController

  layout "private"
  filter_access_to :all

  def index
    @manufacturers = Manufacturer.all.order("name ASC")
    @page_title = "Manufacturers"
  end

  def new
    @manufacturer = Manufacturer.new
    @page_title = "New Manufacturer"
  end

  def create
    @manufacturer = Manufacturer.new(params[:manufacturer])
    @page_title = "New Manufacturer"
    if @manufacturer.save
      flash[:notice] = "Manufacturer created!"
      redirect_to private_manufacturers_url
    else
      render :action => :new
    end
  end

  def edit
    @manufacturer = Manufacturer.find(params[:id])
    @page_title = "Edit #{@manufacturer.name}"
  end

  def update
    @manufacturer = Manufacturer.find(params[:id])
    if @manufacturer.update_attributes(params[:manufacturer])
      flash[:notice] = "Manufacturer updated!"
      redirect_to private_manufacturers_url
    else
      render :action => :edit
    end
  end

  def destroy
    @manufacturer = Manufacturer.find(params[:id])
    @manufacturer.destroy
    flash[:notice] = 'Manufacturer deleted!'
    redirect_to private_manufacturers_url
  end

end
