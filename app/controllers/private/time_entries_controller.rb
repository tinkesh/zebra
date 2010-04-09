class Private::TimeEntriesController < ApplicationController

  layout "private"
  filter_access_to :all

  def edit
    @time_entry = TimeEntry.find(params[:id])
    @time_sheet = TimeSheet.find(:first, :conditions => {:id => @time_entry.time_sheet_id})
    @page_title = "Edit Time Entry ##{@time_entry.id}"
  end

  def update
    @time_entry = TimeEntry.find(params[:id])
    @time_sheet = TimeSheet.find(:first, :conditions => {:id => @time_entry.time_sheet_id})
    if @time_entry.update_attributes(params[:time_entry])
      flash[:notice] = "Time Entry updated!"
      redirect_to edit_private_time_sheet_url(@time_sheet)
    else
      render :action => :edit
    end
  end

end