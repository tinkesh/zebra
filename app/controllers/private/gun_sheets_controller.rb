class Private::GunSheetsController < ApplicationController

  layout "private"
  # filter_access_to :all, :context => :admin

  def index
    @gun_sheets = GunSheet.find(:all)
    @page_title = "Gun Sheets"
  end
  
  def show
    @gun_sheet = GunSheet.find(params[:id], :include => [ :gun_markings ] )
    @page_title = "Showing Gun Sheet ##{@gun_sheet.id}"
  end
  
  def new
    @gun_sheet = GunSheet.new
    load_gun_sheet_supporting_data

    @gun_marking_categories.each do |category| 
      @gun_sheet.gun_markings.build(:gun_marking_category_id => category.id)
    end
    
    @page_title = "New Gun Sheet"
  end
  
  def create
    @gun_sheet = GunSheet.new(params[:gun_sheet])
    if @gun_sheet.save
      flash[:notice] = "Gun Sheet created!"
      redirect_back_or_default private_gun_sheets_url
    else
      render :action => :new
    end
  end

  def edit
    @gun_sheet = GunSheet.find(params[:id])
    load_gun_sheet_supporting_data
    @page_title = "Edit Gun Sheet ##{@gun_sheet.id}"
  end
  
  def update
    @gun_sheet = GunSheet.find(params[:id])
    if @gun_sheet.update_attributes(params[:gun_sheet])
      flash[:notice] = "Gun Sheet updated!"
      redirect_to private_gun_sheets_url
    else
      render :action => :edit
    end
  end

  def destroy
    @gun_sheet = GunSheet.find(params[:id])
    @gun_sheet.destroy
    flash[:notice] = 'Gun Sheet deleted!'
    redirect_to(private_gun_sheets_url)
  end

private

  def load_gun_sheet_supporting_data
    @clients = Client.find(:all, :order => :name)
    @equipment = Equipment.find(:all, :order => :unit)
    @gun_marking_categories = GunMarkingCategory.find(:all, :order => :position)
    @jobs = Job.find(:all)
  end

end