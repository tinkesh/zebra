class PrivateController < ApplicationController

  layout "private"
  filter_access_to :all

  def index
    if current_user.employment_state != "Employed"
      flash[:notice] = "Must be employed to log in"
      current_user_session.destroy
      redirect_to root_url
    end

    if current_user.role_symbols.size == 1 && current_user.role_symbols.include?(:parking_lot)
      redirect_to parking_lot_division_private_jobs_url and return 
    end



    @crew = current_user.crew
    if current_user.role_symbols.include?(:admin) || current_user.role_symbols.include?(:office)
      @jobs = Job.order(:id).all
    else
      if @crew
        @jobs = current_user.crew.jobs
      end
    end
  end

  def navigate
    if params[:navigate] && params[:job] && params[:job][:id]
      @job = Job.find(params[:job][:id])

      cookies.permanent[:selected_job_id] = @job.id
      case params[:navigate]
        when "show_job" then @redirect = private_job_path(@job.id)
        when "clock_in" then @redirect = url_for :controller => "private/clock_in",  :action => "new"
        when "clock_out" then @redirect = url_for :controller => "private/clock_out", :action => "new"
        when "new_time_sheet" then @redirect = url_for new_private_time_sheet_path
        when "new_load_sheet" then @redirect = url_for new_private_load_sheet_path
        when "new_gun_sheet" then @redirect = url_for new_private_job_gun_sheet_path(:job_id => @job.id)
        when "new_job_sheet" then @redirect = url_for new_private_job_sheet_path(:job_id => @job.id)
      end
      redirect_to @redirect
    else
      redirect_to :action => 'index'
    end
  end

#  def permission_denied
#   flash[:error] = 'Sorry, you are not allowed to view the requested page.'
#   redirect_to private_home_path
#  end

end
