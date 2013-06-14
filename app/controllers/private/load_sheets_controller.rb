class Private::LoadSheetsController < ApplicationController

  layout "private"
  filter_access_to :all

  def index
    @page_title = "Load Sheets"

    @load_sheets = LoadSheet
    if params[:query].present?
      @load_sheets = @load_sheets.where('jobs.name ilike :query OR load_sheets.location_name ilike :query OR equipment.name ilike :query', :query => "%#{params[:query]}%")
    end
    @load_sheets = @load_sheets.paginate :page => params[:page], :order => 'load_sheets.id DESC', :per_page => 50, :include => [:equipment, :job]
  end

  def show
    @load_sheet = LoadSheet.find(params[:id], :include => [ :load_entries ] )
    @page_title = @load_sheet.label
  end

  def new
    @load_sheet = LoadSheet.new #(:date => Date.today)
    @crew = current_user.crew
    load_load_sheet_supporting_data
    users_paint_tracks = (current_user.crew.equipments.select{|item| item.unit.starts_with? 'LPT'} rescue [])
    @equipment = users_paint_tracks #if users_paint_tracks.any?
    6.times { @load_sheet.load_entries.build }
    @page_title = "New Load Sheet"
  end

  def create
    @load_sheet = LoadSheet.new(params[:load_sheet])
    load_load_sheet_supporting_data
    @page_title = "New Load Sheet"
    if @load_sheet.save
      if params[:submit_and_create_another_load_sheet].present?
        flash[:success] = "Load Sheet created!"
        redirect_to new_private_load_sheet_path
      else
        if @load_sheet.job
          flash[:success] = "Load Sheet created!"
          redirect_to private_job_url(:id => @load_sheet.job_id)
        else
          flash[:success] = "Load Sheet created! Redirected to home since there was no job assigned to the load sheet."
          redirect_to "/admin"
        end
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
    load_load_sheet_supporting_data
    if @load_sheet.update_attributes(params[:load_sheet])
      flash[:success] = "Load Sheet updated!"
      redirect_to private_load_sheet_path(@load_sheet)
    else
      render :action => :edit
    end
  end

  def destroy
    @load_sheet = LoadSheet.find(params[:id])
    @load_sheet.destroy
    flash[:success] = 'Load Sheet deleted!'
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
