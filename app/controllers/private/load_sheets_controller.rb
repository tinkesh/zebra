class Private::LoadSheetsController < ApplicationController

  layout "private"
  filter_access_to :all

  def index
    @load_sheets = LoadSheet.paginate :page => params[:page], :order => 'id DESC', :per_page => 50, :include => [:equipment, :job]
    @page_title = "Load Sheets"
    @search = LoadSheet.search(params[:search])
    if params[:commit] == "Search"
      @load_sheets = @search.paginate :page => params[:page], :order => 'id DESC', :per_page => 50, :include => [:equipment, :job]
    end
  end

  def show
    @load_sheet = LoadSheet.find(params[:id], :include => [ :load_entries ] )
    @page_title = @load_sheet.label
  end

  def new
    @load_sheet = LoadSheet.new
    @crew = current_user.crew
    load_load_sheet_supporting_data
    6.times { @load_sheet.load_entries.build }
    @page_title = "New Load Sheet"
  end

  def edit_stuff
    redirect_to
  end

  def create
    @load_sheet = LoadSheet.new(params[:load_sheet])
    load_load_sheet_supporting_data
    @page_title = "New Load Sheet"
    if @load_sheet.save
      if @load_sheet.job
        flash[:notice] = "Load Sheet created!"
        redirect_to private_job_url(:id => @load_sheet.job_id)
      else
        flash[:notice] = "Load Sheet created! Redirected to home since there was no job assigned to the load sheet."
        redirect_to "/admin"
      end
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
    @materials = Material.includes(:manufacturer).order("category, manufacturers.name").where(:is_archived => false)
    @allequipment = Equipment.order(:unit)
    @equipment = @allequipment.select{|item| item.unit.starts_with? 'LPT'}
    @jobs = Job.all
  end

end
