class PrivateController < ApplicationController

  layout "private"
  filter_access_to :all

  def index
    @jobs = current_user.jobs
    @page_title = "Dashboard"
  end

  def navigate
    # set current_job session
    @job = Job.find(params[:job_id])
    if params[:navigate] && params[:job_id]
      case params[:navigate]
        when "show_job" : @redirect = private_job_path(@job)
        when "clock_in" : @redirect = link_to()
        when "clock_out" : @redirect =
        when "new_time_sheet" : @redirect =
        when "new_gun_sheet" : @redirect =
      end
      redirect_to @redirect
    else
      render :index
    end
    # check for params
    # redirect to link
  end

  def settings
    @page_title = "Settings"
  end

end