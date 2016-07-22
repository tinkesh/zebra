class Private::TimeSheetsController < ApplicationController

  layout "private"
  filter_access_to :all, :attribute_check => true

  def index
    @time_sheets = TimeSheet.includes(:user, :jobs, :time_entries).order('time_sheets.created_at DESC')
    @page_title = "Time Sheets"

    if params[:crew_id].present?
      @time_sheets = @time_sheets.where('users.crew_id = ?', params[:crew_id])
    end

    @time_sheets = @time_sheets.paginate :page => params[:page], :per_page => 50
  end

  def show
    @time_sheet = TimeSheet.find(params[:id], :include => [ {:time_tasks => :time_task_category}, :time_entries, :time_note_category])
    @page_title = @time_sheet.label
  end

  def new
    @time_sheet = TimeSheet.new
    @time_sheet.created_by = current_user.id

    load_time_sheet_job_and_crew_info
    load_time_sheet_supporting_data
    assign_daily_report_info

    5.times { @time_sheet.time_tasks.build }

    @page_title = "Submit Time Sheet"
  end

  def create
    load_time_sheet_supporting_data
    @page_title = "Submit Clock In/Clock Out Times"
    @time_sheet = TimeSheet.new(params[:time_sheet])
    @time_sheet.created_by = current_user.id
    if @time_sheet.save
      current_user.daily_report.try(:destroy)  # This means the user has finished and is no longer in the 'submit a daily report' mode

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
      load_time_sheet_job_and_crew_info
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
    load_time_sheet_supporting_data
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

private

  def load_time_sheet_supporting_data
    @time_task_categories = TimeTaskCategory.order(:position)
    if current_user.role_symbols.include?(:admin) || current_user.role_symbols.include?(:office)
      @lunch_selections = [0, 30, 45, 60, 75, 90, 105, 120, 150, 180, 210, 240, 270, 300]
    else
      @lunch_selections = [30, 45, 60, 75, 90, 105, 120, 150, 180, 210, 240, 270, 300]
    end
  end

  def load_time_sheet_job_and_crew_info
    if current_user.crew
      user_ids = []
      @users = current_user.crew.users
      @users.each { |u| user_ids << u.id }
      @jobs = (current_user.crew.jobs rescue Job.all)
      @entries = TimeEntry.where(:time_sheet_id => nil, :user_id => user_ids).includes(:user).all
    else
      @users = User.where(:employment_state => "Employed").all
      @jobs = Job.all
      @entries = TimeEntry.where(:time_sheet_id => nil).includes(:user).all
    end

    @load_sheets = current_user.try(:daily_report).try(:load_sheets)
    @gun_sheets = current_user.try(:daily_report).try(:load_sheets)
  end

  def generate_front_to_back
    @date = Time.zone.now
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

  def assign_daily_report_info
    if current_user.daily_report.present?
      # Theres a little bit of vomit in my mouth as I write this
      @time_sheet.questions[:load] = Hash.new()
      @time_sheet.questions[:load][:answer] = (current_user.daily_report.loaded? ? 'yes' : 'no')

      @time_sheet.questions[:paint] = Hash.new()
      @time_sheet.questions[:paint][:answer] = (current_user.daily_report.painted? ? 'yes' : 'no')
    end
  end

end
