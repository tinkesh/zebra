class Private::JobsController < ApplicationController

  layout "private"
  filter_access_to :only => [:index, :new, :update, :edit, :destroy, :create, :revert, :load_job_supporting_data]

  def index
    @page_title = "Jobs on Hand"
    @searched_jobs = Job.where(:is_archived => false).includes(:client, :completion, :job_markings).order('jobs.id DESC')

    if params[:query].present?
      @searched_jobs = @searched_jobs.where('jobs.name ilike :query OR location_name ilike :query OR clients.name ilike :query', :query => "%#{params[:query]}%")
    end
  end


  def archived_jobs
    @page_title = "Archived Jobs on Hand"
    @search = Job.search(params[:search])
    @searched_jobs = @search.all(:conditions => {:is_archived => true}, :include => [:client, :completion])
  end

  def show
    @job = Job.find(params[:id], :include => [:job_locations, :completion, :client, :load_sheets, {:job_markings => :gun_marking_category}, :job_sheets ])

    if params[:version]
      if params[:version].to_i >= @job.last_version
        params[:version] = nil
      else
        @job.revert_to(params[:version].to_i)
      end
    end
    @page_title = @job.label
  end

  # This is a bit of a hack to get a quickie show archived type thing working
  def show_all
    @job = Job.find(params[:id], :include => [:job_locations, :completion, :client, :load_sheets, {:job_markings => :gun_marking_category}, :job_sheets ])

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
    @crews = Crew.all
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
      @job.versioned_user_ids = params[:job][:user_ids].try(:join, ', ').to_s
      @job.save
      flash[:notice] = "Job on Hand created!"
      redirect_to(private_home_path)
    else
      render :action => :new
    end
  end

  def edit
    @job = Job.find(params[:id])
    @crews = Crew.all
    @page_title = "Edit #{@job.label}"
    load_job_supporting_data
  end

  def update
    @job = Job.find(params[:id])
    @job.versioned_at = Time.now

    if @job.update_attributes(params[:job])
     if @job.is_archived == true
       @job.crews.each do |g|
         g = nil
       end
       @job.update_attributes({:crews => []})
     end
      redirect_to private_job_url(@job.id)
    else
      @crews = Crew.all
      load_job_supporting_data
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
    @job.versioned_at = Time.now
    @job.save!
    flash[:notice] = "Job reverted!"
    redirect_to private_job_url(@job.id)
  end

private

  def load_job_supporting_data
    @crews = Crew.all
    @clients = Client.all.order(:name)
    @completions = Completion.all.order(:id)
    @users = User.where(:employment_state => "Employed").order(:first_name).all
    @gun_marking_categories = GunMarkingCategory.all.order(:name)
  end

end
