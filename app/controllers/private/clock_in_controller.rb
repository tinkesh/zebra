class Private::ClockInController < ApplicationController

  layout "private"
  filter_access_to :all

  def new
#    @crew = current_user.crew
    @job = Job.new
    @job.started_on = Time.now
    @clock_in = TimeEntry.new
    build_clocked_in_ids
    @not_clocked_in = TimeEntry.find(:all, :conditions => {:clock_out => nil, :active => nil, :user_id => @crew.user_ids})
    @page_title = "Clock In"
  end

  def create
    @clock_in_time = params[:job][:'started_on(1i)'] + '-' + params[:job][:'started_on(2i)'] + '-'+ params[:job][:'started_on(3i)'] + ' ' + params[:job][:'started_on(4i)'] + ':' + params[:job][:'started_on(5i)']
    build_clocked_in_ids

    if params[:users]
      params[:users].each do |user|
        @entry = TimeEntry.find(:first, :conditions => {:user_id => user[1][:user_id], :active => nil})
        unless @entry.blank?
          @entry.update_attributes(user[1])
        else
          @entry = TimeEntry.new(user[1])
        end
        if @entry.active
          @entry.clock_in = Time.parse(@clock_in_time)
          @entry.clocked_in_at = Time.now
          @entry.clocked_in_by = current_user.id
        end
        @entry.save
      end
    end

    if params[:navigate]
      case params[:navigate]
        when "clock_in" : @redirect = url_for :controller => "private/clock_in",  :action => "new"
        when "clock_out" : @redirect = url_for :controller => "private/clock_out", :action => "new"
        when "home" : @redirect = private_home_path
      end
      flash[:notice] = "Users clocked in!"
      redirect_to @redirect
    else
      redirect_to :controller => 'private/clock_out', :action => :new
    end
  end

private

  def build_clocked_in_ids
    @crew = current_user.crew
    @clocked_in = TimeEntry.find(:all, :conditions => { :time_sheet_id => nil, :active => true, :user_id => @crew.user_ids})
    @clocked_in_ids = []
    unless @clocked_in.empty?
      @clocked_in.each do |entry|
        @clocked_in_ids << entry.user_id
      end
    end
  end

end