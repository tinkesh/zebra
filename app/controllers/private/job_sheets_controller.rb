class Private::JobSheetsController < ApplicationController

  layout "private"
  filter_access_to :all
  filter_access_to [:show, :edit, :update], :attribute_check => true
  filter_access_to [:index, :destroy], :attribute_check => false

  def index
    @job_sheets = JobSheet.paginate :page => params[:page], :order => 'created_at DESC', :per_page => 50
    @page_title = "Job Sheets"
    @search = JobSheet.search(params[:search])
    if params[:commit] == "Search"
      @job_sheets = @search.paginate :page => params[:page], :per_page => 50, :order => 'created_at DESC'
    end
  end

  def show
    @job_sheet = JobSheet.find(params[:id], :include => [{:time_sheets => [:time_entries => :user]}, {:job => [{:gun_sheets => :gun_markings}, :job_markings, :estimates]}])
    @page_title = @job_sheet.job.label
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
    @job_sheet.created_by = current_user.id
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
    @job = Job.find(@job_sheet.job_id)
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
