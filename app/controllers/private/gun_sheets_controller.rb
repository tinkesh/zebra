class Private::GunSheetsController < ApplicationController

  layout "private"
  filter_access_to :all

  def index
    @page_title = "Gun Sheets"

    @gun_sheets = GunSheet
    if params[:query].present?
      @gun_sheets = @gun_sheets.where('jobs.name ilike :query OR gun_sheets.location_name ilike :query OR job_locations.name ilike :query', :query => "%#{params[:query]}%")
    end
    @gun_sheets = @gun_sheets.paginate :page => params[:page], :order => 'gun_sheets.id DESC', :per_page => 50, :include => [:job, :equipment, :job_location]
  end

  def show
    @gun_sheet = GunSheet.find(params[:id], :include => [ :gun_markings ] )
    @page_title = @gun_sheet.label

    if @gun_sheet.created_by
      user = User.find(@gun_sheet.created_by)
      @name = user.first_name + " " + user.last_name
    end
  end

  def new
    @jobs = (current_user.crew.jobs rescue [])

    if (params[:gun_sheet][:job_id].present? rescue false)
      @job = Job.find(params[:gun_sheet][:job_id])
    elsif params[:job_id].present?
      @job = Job.find(params[:job_id])
    else
      @job = @jobs.first
    end

    @gun_sheet = GunSheet.new
    @gun_sheet.created_by = current_user.id
    load_gun_sheet_supporting_data
    @job.job_markings.each do |marking|
      @gun_sheet.gun_markings.build(:gun_marking_category_id => marking.gun_marking_category_id)
    end

    @gun_sheet.set_guns_to_zero

    2.times do @gun_sheet.gun_markings.build end

    @page_title = "New Gun Sheet"
  end

  def create
    @jobs = (current_user.crew.jobs rescue [])

    if (params[:gun_sheet][:job_id].present? rescue false)
      @job = Job.find(params[:gun_sheet][:job_id])
    elsif params[:job_id].present?
      @job = Job.find(params[:job_id])
    else
      @job = @jobs.first
    end

    @gun_sheet = @job.gun_sheets.build(params[:gun_sheet])
    @gun_sheet.created_by= current_user.id
    load_gun_sheet_supporting_data
    @gun_sheet.daily_report = current_user.daily_report

    if @gun_sheet.save
      flash[:success] = "Gun Sheet created!"

      if params[:submit_and_create_another_gun_sheet].present?
        redirect_to new_private_job_gun_sheet_path(:job_id => @job.id)
      elsif current_user.daily_report.present?   # We are in a Clock Out wizard process. Go to the next step
        redirect_to private_daily_report_path(:finished)
      else
        redirect_to private_job_url(:id => @job.id)
      end
    else
      if @gun_sheet.gun_markings.count < 5 and in_mobile_view?
        4.times do @gun_sheet.gun_markings.build end
      end
      render :action => :new
    end
  end

  def edit
    @gun_sheet = GunSheet.find(params[:id])
    @job = Job.find(@gun_sheet.job_id)
    load_gun_sheet_supporting_data

    if @gun_sheet.gun_markings.count < 5 and in_mobile_view?
      4.times do @gun_sheet.gun_markings.build end
    end

    @page_title = "Edit Gun Sheet ##{@gun_sheet.id}"
  end

  def update
    @gun_sheet = GunSheet.find(params[:id])
    load_gun_sheet_supporting_data
    if @gun_sheet.update_attributes(params[:gun_sheet])
      flash[:notice] = "Gun Sheet updated!"
      redirect_to private_gun_sheet_url(@gun_sheet)
    else
      if @gun_sheet.gun_markings.count < 5 and in_mobile_view?
        4.times do @gun_sheet.gun_markings.build end
      end
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
    #@job = Job.find(params[:job_id]) if params[:job_id]
    @job_locations = @job.job_locations
    @clients = Client.order(:name)
    @equipment = (current_user.crew.equipments.select{|item| item.unit.starts_with? 'LPT'} rescue [])
    @gun_marking_categories = GunMarkingCategory.order(:name)
  end

end
