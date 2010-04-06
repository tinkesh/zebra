class Private::GunSheetsController < ApplicationController

  layout "private"
  filter_access_to :all

  def index
    @gun_sheets = GunSheet.find(:all)
    @page_title = "Gun Sheets"
  end

  def show
    @gun_sheet = GunSheet.find(params[:id], :include => [ :gun_markings ] )
    @page_title = "Gun Sheet ##{@gun_sheet.id}"
  end

  def new
    @job = Job.find(params[:job_id])
    @gun_sheet = GunSheet.new
    load_gun_sheet_supporting_data

    @gun_marking_categories.each do |category|
      @gun_sheet.gun_markings.build(:gun_marking_category_id => category.id)
    end

    @page_title = "New Gun Sheet for " + @job.label
  end

  def create
    @job = Job.find(params[:job_id])
    @gun_sheet = @job.gun_sheets.build(params[:gun_sheet])
    load_gun_sheet_supporting_data

    if @gun_sheet.save
      flash[:notice] = "Gun Sheet created!"
      redirect_to private_job_url(:id => @job.id)
    else
      render :action => :new
    end
  end

  def edit
    @gun_sheet = GunSheet.find(params[:id])
    @job = Job.find(@gun_sheet.job_id)
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
    redirect_to private_gun_sheets_url
  end

private

  def load_gun_sheet_supporting_data
    @job_locations = @job.job_locations
    @clients = Client.find(:all, :order => :name)
    @equipment = Equipment.find(:all, :order => :unit)
    @gun_marking_categories = GunMarkingCategory.find(:all, :order => :position)
  end

end