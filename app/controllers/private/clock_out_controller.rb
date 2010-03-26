class Private::ClockOutController < ApplicationController

  layout "private"
  # filter_access_to :all, :context => :admin

  def new
    @job = Job.find(params[:job_id])
    @not_clocked_in = TimeEntry.find(:all, :conditions => {:job_id => @job.id, :clock_out => nil, :active => nil})
    @clocked_in = TimeEntry.find(:all, :conditions => {:job_id => @job.id, :clock_out => nil, :active => true})
    @time = Time.now
    @page_title = "Clock Out"
  end

  def create
    params[:users].each do |user|
      @entry = TimeEntry.find(:first, :conditions => {:job_id => params[:entries][:job_id], :user_id => user})
      @entry.clock_out = params[:entries][:clock_out]
      @entry.clocked_out_at = Time.now
      @entry.save
    end
    redirect_to :action => :new
  end

end