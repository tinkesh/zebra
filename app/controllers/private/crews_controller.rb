class Private::CrewsController < ApplicationController

  layout "private"
  filter_access_to :all

  def index
    @crews = Crew.find(:all, :order => "name ASC")
    @unassigned_equipment = Equipment.unassigned
    @page_title = "Crews"
  end

  def new
    @crew = Crew.new
    @users = User.find(:all, :order => "first_name ASC", :conditions => {:employment_state => "Employed"})
    @equipment = Equipment.find(:all, :order => :unit)
    @page_title = "New Crew"
  end

  def create
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

  def edit
    @crew = Crew.find(params[:id])
    @users = User.find(:all, :order => "first_name ASC", :conditions => {:employment_state => "Employed"})
    @equipment = Equipment.find(:all, :order => :unit)
    @page_title = "Edit #{@crew.name}"
  end

  def update
    params[:crew][:user_ids] ||= []
    params[:crew][:equipment_ids] ||= []
    @crew = Crew.find(params[:id])

    @crew.clear_used_equipment_from_other_crews(params[:crew][:equipment_ids])

    if @crew.update_attributes(params[:crew])
      flash[:notice] = "Crew updated!"
      redirect_to private_crews_url
    else
      render :action => :edit
    end
  end

  def destroy
    @crew = Crew.find(params[:id])
    @crew.destroy
    flash[:notice] = 'Crew deleted!'
    redirect_to(private_crews_url)
  end

end
