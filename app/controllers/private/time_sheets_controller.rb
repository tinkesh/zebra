class Private::TimeSheetsController < ApplicationController

  layout "private"
  filter_access_to :all

  def index
    @time_sheets = TimeSheet.paginate :page => params[:page], :order => 'created_at DESC', :per_page => 50, :include => [:jobs, :time_entries]
    @page_title = "Time Sheets"
    @search = TimeSheet.search(params[:search])
    @searched_time_sheets = @search.all
  end

  def show
    @time_sheet = TimeSheet.find(params[:id], :include => [ {:time_tasks => :time_task_category}, :time_entries, :time_note_category])
    @page_title = @time_sheet.label
    get_version
  end

  def new
    @time_sheet = TimeSheet.new
    @time_sheet.created_by = current_user.id

    if current_user.crew
      user_ids = []
      @users = current_user.crew.users
      @users.each { |u| user_ids << u.id }
      @jobs = current_user.crew.jobs
      @entries = TimeEntry.where(:time_sheet_id => nil, :user_id => user_ids).includes(:user).all
    else
      @users = User.where(:employment_state => "Employed").all
      @jobs = Job.all
      @entries = TimeEntry.where(:time_sheet_id => nil).includes(:user).all
    end

    load_time_sheet_supporting_data
    5.times { @time_sheet.time_tasks.build }

    @page_title = "Submit Time Sheet"
  end

  def create
    load_time_sheet_supporting_data
    @page_title = "Submit Clock In/Clock Out Times"
    @time_sheet = TimeSheet.new(params[:time_sheet])
    @time_sheet.created_by = current_user.id
    if params[:time_sheet][:fuel].blank? : @time_sheet.fuel = 0 end
    if params[:time_sheet][:hotel].blank? : @time_sheet.hotel = 0 end
    if @time_sheet.save

      if params[:time_entry_ids]
        params[:time_entry_ids].each do |entry|
          @entry = TimeEntry.find(entry)
          @entry.time_sheet_id = @time_sheet.id
          @entry.save

          generate_front_to_back
          @entries = TimeEntry.where(:clock_in => @back.to_date...@front.to_date, :user_id => @entry.user_id).order('clock_in ASC').includes(:time_sheet => :estimates)
          @time_sheet.check_hours_of_user_time(@entries)
        end

        if params[:estimates]
          params[:estimates].each do |estimate|
            @estimate = @time_sheet.estimates.build(:job_id => estimate[1][:job_id], :hours => estimate[1][:hours], :crew_size => params[:time_entry_ids].length)
            if @estimate.hours
              @estimate.save
            end
          end
        end

      end

      flash[:notice] = "Time Sheet created!"
      redirect_to private_home_url
    else
      render :action => :new
    end
  end

  def edit
    @time_sheet = TimeSheet.find(params[:id])
    @crew = current_user.crew
    @estimates = Estimate.where(:time_sheet_id => @time_sheet.id).all
    @entries = @time_sheet.time_entries
    load_time_sheet_supporting_data
    2.times { @time_sheet.time_tasks.build }
    @page_title = "Edit #{@time_sheet.label}"
  end

  def update
    @time_sheet = TimeSheet.find(params[:id])
    if @time_sheet.update_attributes(params[:time_sheet])
      flash[:notice] = "Time Sheet updated!"
      redirect_to private_time_sheet_url(@time_sheet)
    else
      render :action => :edit
    end
  end

  def destroy
    @time_sheet = TimeSheet.find(params[:id])
    @time_sheet.destroy
    flash[:notice] = 'Time Sheet deleted!'
    redirect_to private_time_sheets_url
  end

  def revert
    @time_sheet = TimeSheet.find(params[:id])
    @time_sheet.revert_to(params[:version].to_i)
    @time_sheet.versioned_at = Time.now
    @time_sheet.save!
    flash[:notice] = "User reverted!"
    redirect_to private_time_sheet_url(@time_sheet)
  end

private

  def load_time_sheet_supporting_data
    @time_task_categories = TimeTaskCategory.all.order(:position)
    @time_note_categories = TimeNoteCategory.all.order(:position)
    if current_user.role_symbols.include?(:admin) || current_user.role_symbols.include?(:office)
      @lunch_selections = [0, 30, 45, 60, 75, 90, 105, 120, 150, 180, 210, 240, 270, 300]
    else
      @lunch_selections = [30, 45, 60, 75, 90, 105, 120]
    end
  end

  def get_version
    if params[:version]
      if params[:version].to_i >= @time_sheet.last_version
        params[:version] = nil
      else
        @time_sheet.revert_to(params[:version].to_i)
      end
    end
  end

  def generate_front_to_back
    @date = Time.now
    next_month = @date + 1.month
    last_month = @date - 1.month

    if @date.day <= 23
      @back = last_month.year.to_s + "-" + last_month.month.to_s + "-" + "24"
      @front = @date.year.to_s + "-" + @date.month.to_s + "-" + "24"
    else
      @back = @date.year.to_s + "-" + @date.month.to_s + "-" + "24"
      @front = next_month.year.to_s + "-" + next_month.month.to_s + "-" + "24"
    end
  end

end
