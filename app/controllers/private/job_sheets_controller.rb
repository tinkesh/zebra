class Private::JobSheetsController < ApplicationController

  layout "private"
  filter_access_to :all

  def index
    @job_sheets = JobSheet.find(:all)
    @page_title = "Job Sheets"
  end

  def show
    @job_sheet = JobSheet.find(params[:id], :include => [{:time_sheets => [:time_entries => :user]}, {:job => [{:gun_sheets => :gun_markings}, :equipments, :users, :job_markings]}])
    @page_title = "Job Sheet ##{@job_sheet.id}"
    @job_marking_cats = Array.new
  end

  def new
    @job = Job.find(params[:job_id])
    @job_sheet = JobSheet.new
    @page_title = "New Job Sheet for #{@job.label}"
  end

  def create
    @job = Job.find(params[:job_id])
    @job_sheet = @job.job_sheets.build(params[:job_sheet])
    if @job_sheet.save
      flash[:notice] = "Job Sheet created!"
      redirect_to private_job_sheet_url(@job_sheet)
    else
      render :action => :new
    end
  end

  def edit
    @job_sheet = JobSheet.find(params[:id])
    @job = Job.find(@job_sheet.job_id)
    @page_title = "Edit Job Sheet #{@job_sheet.id}"
  end

  def update
    @job_sheet = JobSheet.find(params[:id])
    if @job_sheet.update_attributes(params[:job_sheet])
      flash[:notice] = "Job Sheet updated!"
      redirect_to private_job_sheet_url(@job_sheet)
    else
      render :action => :edit
    end
  end

  def destroy
    @job_sheet = JobSheet.find(params[:id])
    @job_sheet.destroy
    flash[:notice] = 'Job Sheet deleted!'
    redirect_to(private_job_sheets_url)
  end

end