class Private::TimeSheetsController < ApplicationController

  layout "private"
  # filter_access_to :all, :context => :admin

  def index
    @time_sheets = TimeSheet.find(:all)
    @page_title = "Time Sheets"
  end
  
  def new
    @time_sheet = TimeSheet.new
    @job = Job.find(params[:job_id])
    @time_task_categories = TimeTaskCategory.find(:all, :order => :position)
    @time_note_categories = TimeNoteCategory.find(:all, :order => :position)
    @page_title = "New Time Sheet"
    5.times { @time_sheet.time_tasks.build }
    @job.users.each do |user|
       @time_sheet.time_entries.build(:user_id => user.id, :name => "#{user.first_name} #{user.last_name}" )
    end
  end
  
  def create
    @job = Job.find(params[:job_id])
    @time_sheet = @job.time_sheets.build(params[:time_sheet])
    if @time_sheet.save
      flash[:notice] = "Time Sheet created!"
      redirect_back_or_default private_time_sheets_url
    else
      render :action => :new
    end
  end

  def edit
    @time_sheet = TimeSheet.find(params[:id])
    @page_title = "Edit #{@time_sheet.name}"
  end
  
  def update
    @time_sheet = TimeSheet.find(params[:id])
    if @time_sheet.update_attributes(params[:time_sheet])
      flash[:notice] = "Time Sheet updated!"
      redirect_to private_time_sheets_url
    else
      render :action => :edit
    end
  end

  def destroy
    @time_sheet = TimeSheet.find(params[:id])
    @time_sheet.destroy
    flash[:notice] = 'Time Sheet deleted!'
    redirect_to(private_time_sheets_url)
  end

end