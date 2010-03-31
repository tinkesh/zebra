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
    load_time_sheet_supporting_data
    @page_title = "New Time Sheet for " + @job.label
  end

  def create
    @job = Job.find(params[:job_id])
    @time_sheet = @job.time_sheets.build(params[:time_sheet])
    if params[:time_sheet][:fuel].blank? : @time_sheet.fuel = 0 end
    if params[:time_sheet][:hotel].blank? : @time_sheet.hotel = 0 end
    load_time_sheet_supporting_data
    @page_title = "New Time Sheet"
    if @time_sheet.save
      if params[:time_entry_ids]
        params[:time_entry_ids].each do |entry|
          @entry = TimeEntry.find(entry)
          @entry.time_sheet_id = @time_sheet.id
          @entry.save
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
    @job = Job.find(@time_sheet.job_id)
    load_time_sheet_supporting_data
    @page_title = "Edit Time Sheet ##{@time_sheet.id}"
  end

  def update
    @time_sheet = TimeSheet.find(params[:id])
    if @time_sheet.update_attributes(params[:time_sheet])
      flash[:notice] = "Time Sheet updated!"
      redirect_to private_home_url
    else
      render :action => :edit
    end
  end

  def destroy
    @time_sheet = TimeSheet.find(params[:id])
    @time_sheet.destroy
    flash[:notice] = 'Time Sheet deleted!'
    redirect_to private_home_url
  end

private

  def load_time_sheet_supporting_data
    @entries = TimeEntry.find(:all, :conditions => { :job_id => @job.id, :time_sheet_id => nil}, :include => :user)
    @time_task_categories = TimeTaskCategory.find(:all, :order => :position)
    @time_note_categories = TimeNoteCategory.find(:all, :order => :position)
    @lunch_selections = [30, 45, 60, 75, 90, 105, 120]
    @time_selections = Array.new

    36.times do |i|
      @time_selections << -(9 - (i * 0.25))
    end

    37.times do |i|
      @time_selections << +(i * 0.25)
    end

    5.times { @time_sheet.time_tasks.build }
  end

end