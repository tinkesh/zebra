class Private::TimeNoteCategoriesController < ApplicationController

  layout "private"
  # filter_access_to :all, :context => :admin

  def index
    @time_note_categories = TimeNoteCategory.find(:all, :order => "position ASC")
    @page_title = "Time Sheet Note Categories"
  end

  def new
    @time_note_category = TimeNoteCategory.new
    @page_title = "New Time Sheet Note Category"
  end

  def create
    @time_note_category = TimeNoteCategory.new(params[:time_note_category])
    @page_title = "New Time Sheet Note Category"
    if @time_note_category.save
      flash[:notice] = "Time Sheet Note Category created!"
      redirect_back_or_default private_time_note_categories_url
    else
      render :action => :new
    end
  end

  def edit
    @time_note_category = TimeNoteCategory.find(params[:id])
    @page_title = "Edit #{@time_note_category.name}"
  end

  def update
    @time_note_category = TimeNoteCategory.find(params[:id])
    if @time_note_category.update_attributes(params[:time_note_category])
      flash[:notice] = "Time Sheet Note Category updated!"
      redirect_to private_time_note_categories_url
    else
      render :action => :edit
    end
  end

  def destroy
    @time_note_category = TimeNoteCategory.find(params[:id])
    @time_note_category.destroy
    flash[:notice] = 'Time Sheet Note Category deleted!'
    redirect_to private_time_note_categories_url
  end

end