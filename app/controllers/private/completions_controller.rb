class Private::CompletionsController < ApplicationController

  layout "private"
  # filter_access_to :all

  def index
    @completions = Completion.find(:all, :order => "name ASC")
    @page_title = "Job Completion Levels"
  end

  def new
    @completion = Completion.new
    @page_title = "New Completion Level"
  end

  def create
    @completion = Completion.new(params[:completion])
    if @completion.save
      flash[:notice] = "Completion Level created!"
      redirect_to private_completions_url
    else
      render :action => :new
    end
  end

  def edit
    @completion = Completion.find(params[:id])
    @page_title = "Edit #{@completion.name}"
  end

  def update
    @completion = Completion.find(params[:id])
    if @completion.update_attributes(params[:completion])
      flash[:notice] = "Completion Level updated!"
      redirect_to private_completions_url
    else
      render :action => :edit
    end
  end

  def destroy
    @completion = Completion.find(params[:id])
    @completion.destroy
    flash[:notice] = 'Completion Level deleted!'
    redirect_to private_completions_url
  end

end