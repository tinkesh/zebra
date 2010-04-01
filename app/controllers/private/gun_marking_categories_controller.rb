class Private::GunMarkingCategoriesController < ApplicationController

  layout "private"
  filter_access_to :all

  def index
    @gun_marking_categories = GunMarkingCategory.find(:all, :order => "position ASC")
    @page_title = "Gun Marking Categories"
  end

  def new
    @gun_marking_category = GunMarkingCategory.new
    @page_title = "New Gun Marking Category"
  end

  def create
    @gun_marking_category = GunMarkingCategory.new(params[:gun_marking_category])
    @page_title = "New Gun Marking Category"
    if @gun_marking_category.save
      flash[:notice] = "Gun Marking Category created!"
      redirect_to private_gun_marking_categories_url
    else
      render :action => :new
    end
  end

  def edit
    @gun_marking_category = GunMarkingCategory.find(params[:id])
    @page_title = "Edit #{@gun_marking_category.name}"
  end

  def update
    @gun_marking_category = GunMarkingCategory.find(params[:id])
    if @gun_marking_category.update_attributes(params[:gun_marking_category])
      flash[:notice] = "Gun Marking Category updated!"
      redirect_to private_gun_marking_categories_url
    else
      render :action => :edit
    end
  end

  def destroy
    @gun_marking_category = GunMarkingCategory.find(params[:id])
    @gun_marking_category.destroy
    flash[:notice] = 'Gun Marking Category deleted!'
    redirect_to private_gun_marking_categories_url
  end

end