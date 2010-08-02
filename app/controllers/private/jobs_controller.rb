class Private::JobsController < ApplicationController

  layout "private"
  filter_access_to :only => [:index, :new, :update, :edit, :destroy, :create, :revert, :load_job_supporting_data]

  def index
    @jobs = Job.find(:all, :include => [:client, :completion], :conditions => {:is_archived => 0})
    @page_title = "Jobs on Hand"
  end


  def archived_jobs
    @jobs = Job.find(:all, :include => [:client, :completion], :conditions => {:is_archived => 1})
    @page_title = "Archived Jobs"
  end

  def show
    @job = Job.find(params[:id], :include => [:job_locations, :completion, :client, :load_sheets, {:job_markings => :gun_marking_category}, :job_sheets ])

#    unless @job.crews.users.include?(current_user) || current_user.role_symbols.include?(:admin) || current_user.role_symbols.include?(:office)
#      redirect_to '/admin'
#    end

    if params[:version]
      if params[:version].to_i >= @job.last_version
        params[:version] = nil
      else
        @job.revert_to(params[:version].to_i)
      end
    end
    @page_title = @job.label

  end

  def new
    @job = Job.new
    @crews = Crew.find(:all)
    1.times { @job.job_markings.build }
    @page_title = "New Job on Hand"
    load_job_supporting_data
  end

  def create
    @job = Job.new(params[:job])
    @page_title = "New Job on Hand"
    load_job_supporting_data
    if @job.save
      @job.versioned_at = Time.now
      if params[:job][:user_ids] : @job.versioned_user_ids = params[:job][:user_ids].join(', ').to_s else '' end
      if params[:job][:equipment_ids] : (@job.versioned_equipment_ids = params[:job][:equipment_ids].join(', ').to_s) else '' end
      @job.save
      flash[:notice] = "Job on Hand created!"
      redirect_to(private_home_path)
    else
      render :action => :new
    end
  end

  def edit
    @job = Job.find(params[:id])
    @crews = Crew.find(:all)
    @page_title = "Edit #{@job.label}"
    load_job_supporting_data
  end

  def update
    @job = Job.find(params[:id])
#    params[:job][:user_ids] ||= []
    params[:job][:equipment_ids] ||= []
    @job.versioned_at = Time.now
#    if params[:job][:user_ids] : @job.versioned_user_ids = params[:job][:user_ids].join(', ').to_s else '' end
    if params[:job][:equipment_ids] : (@job.versioned_equipment_ids = params[:job][:equipment_ids].join(', ').to_s) else '' end
    if @job.update_attributes(params[:job])
     # flash[:notice] = "Job on Hand updated!"
     if @job.is_archived == true
       @job.crews.each do |g|
         g = nil
       end
       @job.update_attributes({:crews => []})
     end
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

  def revert
    @job = Job.find(params[:id])
    @job.revert_to(params[:version].to_i)
    @job.user_ids = @job.versioned_user_ids.split(", ")
    @job.equipment_ids = @job.versioned_equipment_ids.split(", ")
    @job.versioned_at = Time.now
    @job.save!
    flash[:notice] = "Job reverted!"
    redirect_to private_job_url(@job)
  end

private

  def load_job_supporting_data
    @clients = Client.find(:all, :order => :name)
    @completions = Completion.find(:all, :order => :id)
    @users = User.find(:all, :order => :first_name, :conditions => {:employment_state => "Employed"})
    @equipments = Equipment.find(:all, :order => :unit)
    @gun_marking_categories = GunMarkingCategory.find(:all, :order => :name)
  end

end