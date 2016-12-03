class Private::CrewsController < ApplicationController

  layout "private"
  filter_access_to :all
  before_filter :find_crew, only: [:show, :edit, :update, :destroy, :check_forman, :delete_job]
  before_filter :check_forman, only: [:show]

  def index
    @crews = Crew.includes(:jobs, :equipments, :users).order('name ASC')
    @unassigned_equipment = Equipment.unassigned
    @page_title = "Crews"
  end

  def new
    @crew = Crew.new
    @users = User.where(:employment_state => 'Employed').order("first_name ASC")
    @equipment = Equipment.order(:unit).all
    @page_title = "New Crew"
  end

  def create
    @users = User.where(:employment_state => 'Employed').order("first_name ASC")
    @equipment = Equipment.order(:unit).all
    @crew = Crew.new
    @crew.clear_used_equipment_from_other_crews(params[:crew][:equipment_ids])
    @crew = Crew.new(params[:crew])
    @page_title = "New Crew"
    if @crew.save
      flash[:notice] = "Crew created!"
      redirect_to private_crews_url
    else
      render :action => :new
    end
  end

  def show
    @page_title = "#{@crew.name}"
    @jobs = @crew.jobs
  end

  def edit
    @users = User.where(:employment_state => 'Employed').order("first_name ASC")
    @equipment = Equipment.order(:unit).all
    @page_title = "Edit #{@crew.name}"
  end

  def update
    @users = User.where(:employment_state => 'Employed').order("first_name ASC")
    @equipment = Equipment.order(:unit).all
    params[:crew][:user_ids] ||= []
    params[:crew][:equipment_ids] ||= []
    @crew.clear_used_equipment_from_other_crews(params[:crew][:equipment_ids])

    if @crew.update_attributes(params[:crew])
      flash[:notice] = "Crew updated!"
      redirect_to private_crews_url
    else
      render :action => :edit
    end
  end

  def destroy
    @crew.destroy
    flash[:notice] = 'Crew deleted!'
    redirect_to(private_crews_url)
  end

  def calendar
    if current_user.role_symbols.size == 1 && current_user.role_symbols.include?(:foreman)
      @crews = Crew.joins(:users).where('users.id = ?', current_user.id)
    else
      @crews = Crew.includes(:jobs, :equipments, :users).order('name ASC')
    end
    @page_title = "Calendar"
  end

  def delete_job
    job = Job.find(params[:job_id])
    @crew.jobs.delete(job)
    flash[:notice] = "Job-#{job.name} deleted from #{@crew.label}!"
    redirect_to private_crews_url
  end


  private

  def find_crew
    @crew = Crew.find(params[:id])
  end

  def check_forman
    ['supervisor', 'office', 'admin', 'superadmin'].each do |role|
      return if current_user.roles.map(&:name).include? role
    end

    if !@crew.user_list.include?(current_user.name)
      flash[:error] = "Sorry, you are not allowed to access that page."
      redirect_to private_home_url
    end
  end
end
