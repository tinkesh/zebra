class Private::GunSheetsController < ApplicationController

  layout "private"
  filter_access_to :all

  def index
    @gun_sheets = GunSheet.paginate :page => params[:page], :order => 'id DESC', :per_page => 50, :include => [:job, :equipment]
    @page_title = "Gun Sheets"

    @search = GunSheet.search(params[:search])

    if params[:commit] == "Search"
      @gun_sheets = @search.paginate :page => params[:page], :per_page => 50, :order => 'id DESC', :include => [:job, :equipment]
    end
  end

  def show
    @gun_sheet = GunSheet.find(params[:id], :include => [ :gun_markings ] )
    @page_title = @gun_sheet.label

    if @gun_sheet.created_by
      name = User.find(@gun_sheet.created_by)
      @name = name[0].first_name + " " + name[0].last_name
    end
  end

  def new
    @job = Job.find(params[:job_id])
    @gun_sheet = GunSheet.new
    @gun_sheet.created_by = current_user.id
    load_gun_sheet_supporting_data
    @job.job_markings.each do |marking|
      @gun_sheet.gun_markings.build(:gun_marking_category_id => marking.gun_marking_category_id)
    end

    @gun_sheet.set_guns_to_zero

    2.times do @gun_sheet.gun_markings.build end

    @page_title = "New Gun Sheet for " + @job.label
  end

  def create
    @job = Job.find(params[:job_id])
    @gun_sheet = @job.gun_sheets.build(params[:gun_sheet])
    @gun_sheet.created_by= current_user.id
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

    4.times do @gun_sheet.gun_markings.build end

    @page_title = "Edit Gun Sheet ##{@gun_sheet.id}"
  end

  def update
    @gun_sheet = GunSheet.find(params[:id])
    if @gun_sheet.update_attributes(params[:gun_sheet])
      flash[:notice] = "Gun Sheet updated!"
      redirect_to private_gun_sheet_url(@gun_sheet)
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

  def print_selected
    @gun_sheets = GunSheet.where(:id => params[:gun_sheet_ids])
  end

private

  def load_gun_sheet_supporting_data
    @job_locations = @job.job_locations
    @clients = Client.all.order(:name)
    @allequipment = Equipment.all.order(:unit)
    @equipment = @allequipment.find_all{|item| item.unit.starts_with? 'LPT'}
    @gun_marking_categories = GunMarkingCategory.all.order(:name)
  end

end
