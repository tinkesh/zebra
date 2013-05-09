class Private::MaterialsController < ApplicationController

  layout "private"
  filter_access_to :all

  def index
    @materials = Material.find(:all, :include => :manufacturer)
    @page_title = "Materials"
  end

  def new
    @material = Material.new
    @page_title = "New Material"
    @manufacturers = Manufacturer.find(:all, :order => 'name ASC')
  end

  def create
    @material = Material.new(params[:material])
    @page_title = "New Material"
    @manufacturers = Manufacturer.find(:all)
    if @material.save
      flash[:notice] = "Material created!"
      redirect_to private_materials_url
    else
      render :action => :new
    end
  end

  def edit
    @material = Material.find(params[:id])
    @manufacturers = Manufacturer.find(:all, :order => 'name ASC')
    @page_title = "Edit #{@material.manufacturer.try(:abbreviation)} Batch ##{@material.batch}"
  end

  def update
    @material = Material.find(params[:id])
    if @material.update_attributes(params[:material])
      flash[:notice] = "Material updated!"
      redirect_to private_materials_url
    else
      render :action => :edit
    end
  end

  def destroy
    @material = Material.find(params[:id])
    @material.destroy
    flash[:notice] = 'Material deleted!'
    redirect_to private_materials_url
  end

end
