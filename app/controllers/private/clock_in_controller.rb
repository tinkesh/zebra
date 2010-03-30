class Private::ClockInController < ApplicationController

  layout "private"
  # filter_access_to :all, :context => :admin

  def new
    @entries = []
    @clocked_in_ids = []
    @job = Job.find(params[:job_id])
    @time = Time.now
    @clock_in = TimeEntry.new
    @not_clocked_in = TimeEntry.find(:all, :conditions => {:job_id => @job.id, :clock_out => nil, :active => nil})
    build_clocked_in_ids(@job.id)
    @page_title = "Clock In"
  end

  def create
    build_clocked_in_ids(params[:job][:id])
    params[:users].each do |attributes|
      attributes[:clock_in] = Time.now
        @entry = TimeEntry.find(:first, :conditions => {:user_id => attributes[:user_id], :job_id => attributes[:job_id], :active => nil})
        unless @entry.blank?
          @entry.update_attributes(attributes)
        else
          @entry = TimeEntry.new(attributes)
        end
      @entry.save
    end

    if params[:navigate] && params[:job_id]
      @job = Job.find(params[:job_id])
      case params[:navigate]
        when "show_job" : @redirect = private_job_path(@job)
        when "clock_in" : @redirect = url_for :controller => "private/clock_in",  :action => "new", :job_id => @job.id
        when "clock_out" : @redirect = url_for :controller => "private/clock_out", :action => "new", :job_id => @job.id
      end
      redirect_to @redirect
    else
      redirect_to :controller => 'private/clock_out', :action => :new
    end
  end

private

  def build_clocked_in_ids(job)
    @clocked_in = TimeEntry.find(:all, :conditions => {:job_id => job, :clock_out => nil, :active => true})
    @clocked_in_ids = []
    unless @clocked_in.empty?
      @clocked_in.each do |entry|
        @clocked_in_ids << entry.user_id
      end
    end
  end

end