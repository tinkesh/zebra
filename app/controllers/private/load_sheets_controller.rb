class Private::LoadSheetsController < ApplicationController

  layout "private"
  # filter_access_to :all, :context => :admin

  def index
    @load_sheets = LoadSheet.find(:all)
    @page_title = "Load Sheets"
  end

  def show
    @load_sheet = LoadSheet.find(params[:id], :include => [ :load_entries ] )
    @page_title = "Showing Load Sheet ##{@load_sheet.id}"
  end

  def new
    @load_sheet = LoadSheet.new
    load_load_sheet_supporting_data
    6.times { @load_sheet.load_entries.build }
    @page_title = "New Load Sheet"
  end

  def create
    @load_sheet = LoadSheet.new(params[:load_sheet])
    load_load_sheet_supporting_data
    @page_title = "New Load Sheet"
    if @load_sheet.save
      flash[:notice] = "Load Sheet created!"
      redirect_to private_load_sheets_url
    else
      render :action => :new
    end
  end

  def edit
    @load_sheet = LoadSheet.find(params[:id])
    2.times { @load_sheet.load_entries.build }
    load_load_sheet_supporting_data
    @page_title = "Edit Load Sheet ##{@load_sheet.id}"
  end

  def update
    @load_sheet = LoadSheet.find(params[:id])
    if @load_sheet.update_attributes(params[:load_sheet])
      flash[:notice] = "Load Sheet updated!"
      redirect_to private_load_sheets_url
    else
      render :action => :edit
    end
  end

  def destroy
    @load_sheet = LoadSheet.find(params[:id])
    @load_sheet.destroy
    flash[:notice] = 'Load Sheet deleted!'
    redirect_to private_load_sheets_url
  end

private

  def load_load_sheet_supporting_data
    @materials = Material.find(:all, :include => :manufacturer, :order => :manufacturer_id)
    @equipment = Equipment.find(:all, :order => :unit)
    @jobs = Job.find(:all)
  end

end