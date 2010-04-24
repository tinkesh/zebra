class Private::EstimatesController < ApplicationController

  layout "private"
  filter_access_to :all

  def edit
    @estimate = Estimate.find(params[:id])
    @time_sheet = TimeSheet.find(:first, :conditions => {:id => @estimate.time_sheet_id})
    @page_title = "Estimate for #{@estimate.job.label}"
  end

  def update
    @estimate = Estimate.find(params[:id])
    @time_sheet = TimeSheet.find(:first, :conditions => {:id => @estimate.time_sheet_id})
    if @estimate.update_attributes(params[:estimate])
      flash[:notice] = "Estimate updated!"
      redirect_to edit_private_time_sheet_url(@time_sheet)
    else
      render :action => :edit
    end
  end

end