class Private::LoadSheetsController < ApplicationController

  layout "private"
  filter_access_to :all

  def index
    @load_sheets = LoadSheet.paginate :page => params[:page], :order => 'id DESC', :per_page => 50, :include => [:equipment, :job]
    @page_title = "Load Sheets"

    @search = LoadSheet.search(params[:search])
    if params[:commit] == "Search"
      @load_sheets = @search.paginate :page => params[:page], :per_page => 50, :order => 'id DESC', :include => [:job, :equipment]
    end
  end

  def show
    @load_sheet = LoadSheet.find(params[:id], :include => [ :load_entries ] )
    @page_title = @load_sheet.label

    if params[:version]
      if params[:version].to_i >= @load_sheet.last_version
        params[:version] = nil
      else
        @load_sheet.revert_to(params[:version].to_i)
      end
    end

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
      @load_sheet.versioned_at = Time.now
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
    @load_sheet.versioned_at = Time.now
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

  def revert
    @load_sheet = LoadSheet.find(params[:id])
    @load_sheet.revert_to(params[:version].to_i)
    @load_sheet.versioned_at = Time.now
    @load_sheet.save!
    flash[:notice] = "Load Sheet reverted!"
    redirect_to private_load_sheet_url(@load_sheet)
  end

private

  def load_load_sheet_supporting_data
    @materials = Material.find(:all, :include => :manufacturer, :order => "category, manufacturers.name")
    @allequipment = Equipment.find(:all, :order => :unit)
    @equipment = @allequipment.find_all{|item| item.unit.starts_with? 'LPT'}
    @jobs = Job.find(:all)
  end

end
