class Private::TimeSheetsController < ApplicationController

  layout "private"
  # filter_access_to :all, :context => :admin

  def index
    @time_sheets = TimeSheet.find(:all)
    @page_title = "Time Sheets"
  end
  
  def show
    @time_sheet = TimeSheet.find(params[:id], :include => [ {:time_tasks => :time_task_category}, :time_entries, :time_note_category])
    @page_title = "Showing Time Sheet ##{@time_sheet.id}"
  end
  
  def new
    @job = Job.find(params[:job_id])
    @time_sheet = TimeSheet.new
    5.times { @time_sheet.time_tasks.build }
    @job.users.each do |user|
       @time_sheet.time_entries.build(:user_id => user.id, :name => "#{user.first_name} #{user.last_name}" )
    end

    load_time_sheet_supporting_data
    @page_title = "New Time Sheet"
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
    @job = Job.find(@time_sheet.job_id)
    load_time_sheet_supporting_data
    @page_title = "Edit Time Sheet ##{@time_sheet.id}"
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

private


  def load_time_sheet_supporting_data
    @time_task_categories = TimeTaskCategory.find(:all, :order => :position)
    @time_note_categories = TimeNoteCategory.find(:all, :order => :position)

    @time_selections = Array.new

    36.times do |i|
      @time_selections << -(9 - (i * 0.25))
    end

    37.times do |i|
      @time_selections << +(i * 0.25)
    end
  end

end