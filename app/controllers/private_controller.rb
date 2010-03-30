class PrivateController < ApplicationController

  layout "private"
  filter_access_to :all

  def index
    @jobs = current_user.jobs
    @page_title = "Dashboard"
  end

  def navigate
    # set current_job session
    if params[:navigate] && params[:job_id]
      @job = Job.find(params[:job_id])
      case params[:navigate]
        when "show_job" : @redirect = private_job_path(@job)
        when "clock_in" : @redirect = url_for :controller => "private/clock_in",  :action => "new", :job_id => @job.id
        when "clock_out" : @redirect = url_for :controller => "private/clock_out", :action => "new", :job_id => @job.id
        when "new_time_sheet" : @redirect = url_for new_private_job_time_sheet_path(:job_id => @job.id)
        when "new_gun_sheet" : @redirect = url_for new_private_job_gun_sheet_path(:job_id => @job.id)
      end
      redirect_to @redirect
    else
      redirect_to :action => 'index'
    end
  end

  def settings
    @page_title = "Settings"
  end

end