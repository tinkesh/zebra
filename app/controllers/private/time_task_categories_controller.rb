class Private::TimeTaskCategoriesController < ApplicationController

  layout "private"
  # filter_access_to :all, :context => :admin

  def index
    @time_task_categories = TimeTaskCategory.find(:all, :order => "position ASC")
    @page_title = "Time Sheet Task Categories"
  end
  
  def new
    @time_task_category = TimeTaskCategory.new
    @page_title = "New Time Sheet Task Category"
  end
  
  def create
    @time_task_category = TimeTaskCategory.new(params[:time_task_category])
    if @time_task_category.save
      flash[:notice] = "Time Sheet Task Category created!"
      redirect_back_or_default private_time_task_categories_url
    else
      render :action => :new
    end
  end

  def edit
    @time_task_category = TimeTaskCategory.find(params[:id])
    @page_title = "Edit #{@time_task_category.name}"
  end
  
  def update
    @time_task_category = TimeTaskCategory.find(params[:id])
    if @time_task_category.update_attributes(params[:time_task_category])
      flash[:notice] = "Time Sheet Task Category updated!"
      redirect_to private_time_task_categories_url
    else
      render :action => :edit
    end
  end

  def destroy
    @time_task_category = TimeTaskCategory.find(params[:id])
    @time_task_category.destroy
    flash[:notice] = 'Time Sheet Task Category deleted!'
    redirect_to(private_time_task_categories_url)
  end

end