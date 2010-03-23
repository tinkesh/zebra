class Private::JobsController < ApplicationController

  layout "private"

  def index
    @jobs = Job.find(:all)
    @page_title = "Jobs on Hand"
  end

  def show
    @job = Job.find(params[:id], :include => [ {:users => :roles}, :job_locations, :equipments, :completion, :client, :time_sheets, :load_sheets, {:job_markings => :gun_marking_category}, :job_sheets ])
    @page_title = "Showing Job ##{@job.id}"
  end

  def new
    @job = Job.new
    1.times { @job.job_markings.build }
    @page_title = "New Job"
    load_job_supporting_data
  end

  def create
    @job = Job.new(params[:job])
    if @job.save
      flash[:notice] = "Job created!"
      redirect_back_or_default private_jobs_url
    else
      render :action => :new
    end
  end

  def edit
    @job = Job.find(params[:id])
    @page_title = "Edit Job ##{@job.id}"
    load_job_supporting_data
  end

  def update
    @job = Job.find(params[:id])
    if @job.update_attributes(params[:job])
      flash[:notice] = "Job updated!"
      redirect_to private_jobs_url
    else
      render :action => :edit
    end
  end

  def destroy
    @job = Job.find(params[:id])
    @job.destroy
    flash[:notice] = 'Job deleted!'
    redirect_to(private_jobs_url)
  end

private

  def load_job_supporting_data
    @clients = Client.find(:all, :order => :name)
    @completions = Completion.find(:all, :order => :id)
    @users = User.find(:all, :order => :first_name)
    @equipments = Equipment.find(:all, :order => :unit)
    @gun_marking_categories = GunMarkingCategory.find(:all, :order => :name)
  end

end