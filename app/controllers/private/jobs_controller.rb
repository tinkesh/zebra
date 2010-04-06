class Private::JobsController < ApplicationController

  layout "private"
  filter_access_to :all

  def index
    @jobs = Job.find(:all, :include => [:client, :completion])
    @page_title = "Jobs on Hand"
  end

  def show
    @job = Job.find(params[:id], :include => [ {:users => :roles}, :job_locations, :equipments, :completion, :client, :time_sheets, :load_sheets, {:job_markings => :gun_marking_category}, :job_sheets ])
    unless @job.users.include?(current_user) || current_user.role_symbols.include?(:admin) || current_user.role_symbols.include?(:office)
      redirect_to '/admin'
    end
    @page_title = @job.label
    @job.revert_to(params[:version].to_i) if params[:version]
  end

  def new
    @job = Job.new
    1.times { @job.job_markings.build }
    @page_title = "New Job on Hand"
    load_job_supporting_data
  end

  def create
    @job = Job.new(params[:job])
    @page_title = "New Job on Hand"
    load_job_supporting_data
    if @job.save
      flash[:notice] = "Job on Hand created!"
      redirect_to private_jobs_url
    else
      render :action => :new
    end
  end

  def edit
    @job = Job.find(params[:id])
    @page_title = "Edit #{@job.label}"
    load_job_supporting_data
  end

  def update
    @job = Job.find(params[:id])
    params[:job][:user_ids] ||= []
    params[:job][:equipment_ids] ||= []
    if @job.update_attributes(params[:job])
      flash[:notice] = "Job on Hand updated!"
      redirect_to private_job_url(@job)
    else
      render :action => :edit
    end
  end

  def destroy
    @job = Job.find(params[:id])
    @job.destroy
    flash[:notice] = 'Job on Hand deleted!'
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