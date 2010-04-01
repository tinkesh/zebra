class Private::ClockOutController < ApplicationController

  layout "private"
  filter_access_to :all

  def new
    @job = Job.find(params[:job_id])
    @job.started_on = Time.now
    @clocked_in = TimeEntry.find(:all, :conditions => {:job_id => @job.id, :active => true, :time_sheet_id => nil, :clock_out => nil})
    @entries = TimeEntry.find(:all, :conditions => {:job_id => @job.id, :time_sheet_id => nil})
    @time = Time.now
    @page_title = "Clock Out of " + @job.label
  end

  def create
    @clock_out_time = params[:job][:'started_on(1i)'] + '-' + params[:job][:'started_on(2i)'] + '-'+ params[:job][:'started_on(3i)'] + ' ' + params[:job][:'started_on(4i)'] + ':' + params[:job][:'started_on(5i)']
    if params[:users]
      params[:users].each do |user|
        @entry = TimeEntry.find(:first, :conditions => {:job_id => params[:entries][:job_id], :user_id => user, :clock_out => nil})
        if @entry.active
          @entry.clock_out = @clock_out_time
          @entry.clocked_out_at = Time.now
        end
        @entry.save
      end
    end

    if params[:navigate] && params[:job_id]
      @job = Job.find(params[:job_id])
      case params[:navigate]
        when "show_job" : @redirect = private_job_path(@job)
        when "clock_in" : @redirect = url_for :controller => "private/clock_in",  :action => "new", :job_id => @job.id
        when "clock_out" : @redirect = url_for :controller => "private/clock_out", :action => "new", :job_id => @job.id
        when "new_time_sheet" : @redirect = url_for new_private_job_time_sheet_path(:job_id => @job.id)
      end
      redirect_to @redirect
    else
      redirect_to :controller => 'private/clock_out', :action => :new
    end

  end

end