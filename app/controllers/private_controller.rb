class PrivateController < ApplicationController

  layout "private"
  filter_access_to :all

  def index
    @crew = current_user.crew
    if current_user.role_symbols.include?(:admin) || current_user.role_symbols.include?(:office)
      @jobs = Job.find(:all)
    else
      @jobs = current_user.jobs
    end
#    @page_title = "Dashboard"
  end

  def navigate
    # set current_job session
    if params[:navigate] && params[:job][:id]
      @job = Job.find(params[:job][:id])
      session[:navigate] = @job.id
      case params[:navigate]
        when "show_job" : @redirect = private_job_path(@job)
        when "clock_in" : @redirect = url_for :controller => "private/clock_in",  :action => "new"
        when "clock_out" : @redirect = url_for :controller => "private/clock_out", :action => "new"
        when "new_time_sheet" : @redirect = url_for new_private_time_sheet_path
        when "new_load_sheet" : @redirect = url_for new_private_load_sheet_path
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

#  def permission_denied
#   flash[:error] = 'Sorry, you are not allowed to view the requested page.'
#   redirect_to private_home_path
#  end

end