class Private::TimeEntriesController < ApplicationController

  layout "private"
  filter_access_to :all

  def edit
    @time_entry = TimeEntry.find(params[:id])
    @time_sheet = @time_entry.time_sheet
    @page_title = "Edit Time Entry ##{@time_entry.id}"
  end

  def update
    @time_entry = TimeEntry.find(params[:id])
    @time_sheet = TimeSheet.find(@time_entry.time_sheet_id)
    if @time_entry.update_attributes(params[:time_entry])
      flash[:notice] = "Time Entry updated!"
      redirect_to edit_private_time_sheet_url(@time_sheet)
    else
      render :action => :edit
    end
  end

  def destroy
    @time_entry = TimeEntry.find(params[:id])
    @time_entry.destroy
    flash[:notice] = 'Time Entry deleted!'
    redirect_to report_time_entries_url
  end

end
