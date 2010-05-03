class Private::ClockOutController < ApplicationController

  layout "private"
  filter_access_to :all

  def new
    @crew = current_user.crew
    @job = Job.new
    @job.started_on = Time.zone.now
    @clocked_in = TimeEntry.find(:all, :conditions => {:active => true, :time_sheet_id => nil, :clock_out => nil, :user_id => @crew.user_ids})
    @entries = TimeEntry.find(:all, :conditions => {:time_sheet_id => nil, :user_id => @crew.user_ids})
    @page_title = "Clock Out"
  end

  def create
    @clock_out_time = params[:job][:'started_on(1i)'] + '-' + params[:job][:'started_on(2i)'] + '-'+ params[:job][:'started_on(3i)'] + ' ' + params[:job][:'started_on(4i)'] + ':' + params[:job][:'started_on(5i)'] + ":00"
    if params[:users]
      params[:users].each do |user|
        @entry = TimeEntry.find(:first, :conditions => {:user_id => user, :clock_out => nil, :time_sheet_id => nil})
        if @entry.active
          @entry.clocked_out_by = current_user.id
          @entry.clock_out = Time.zone.parse(@clock_out_time)
          @entry.clocked_out_at = Time.zone.now
        end
        @entry.save
      end
    end

    if params[:navigate]
      case params[:navigate]
        when "clock_in" : @redirect = url_for :controller => "private/clock_in",  :action => "new"
        when "clock_out" : @redirect = url_for :controller => "private/clock_out", :action => "new"
        when "home" : @redirect = url_for private_home_path
        when "new_time_sheet" : @redirect = url_for new_private_time_sheet_path
      end
      flash[:notice] = "Users clocked out!"
      redirect_to @redirect
    else
      redirect_to :controller => 'private/clock_out', :action => :new
    end

  end

end