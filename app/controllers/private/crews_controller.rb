class Private::CrewsController < ApplicationController

  layout "private"
  filter_access_to :all

  def index
    @crews = Crew.find(:all, :order => "name ASC")
    @page_title = "Crews"
  end

  def new
    @crew = Crew.new
    @users = User.find(:all, :order => "first_name ASC", :conditions => {:employment_state => "Employed"})
    @page_title = "New Crew"
  end

  def create
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
    @page_title = "Edit #{@crew.name}"
  end

  def update
    @crew = Crew.find(params[:id])
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