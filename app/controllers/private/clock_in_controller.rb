class Private::ClockInController < ApplicationController

  layout "private"
  filter_access_to :all

  def new
    @job = Job.new
    @job.started_on = Time.zone.now
    @clock_in = TimeEntry.new
    build_clocked_in_ids # also sets @crew and clocked_in_ids
    @not_clocked_in = TimeEntry.find(:all, :conditions => {:clock_out => nil, :active => nil, :user_id => @users})
    @page_title = "Clock In"
  end

  def create
    begin
      @clock_in_time = params[:job][:'started_on(1i)'] + '-' + params[:job][:'started_on(2i)'] + '-'+ params[:job][:'started_on(3i)'] + ' ' + params[:job][:'started_on(4i)'] + ':' + params[:job][:'started_on(5i)'] + ":00"
    rescue Exception => e
      @clock_in_time = Time.now.to_s
    end

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
          @entry.clock_in = Time.zone.parse(@clock_in_time)
          @entry.clocked_in_at = Time.zone.now
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
    @crew = current_user.try(:crew)
    user_ids = []
    @clocked_in_ids = []

    if @crew
      @users = @crew.users
      @crew.users.each {|user| user_ids << user.id}
    else
      @users = User.all
      @users.each {|user| user_ids << user.id}
    end
    @clocked_in = TimeEntry.find(:all, :conditions => { :time_sheet_id => nil, :active => true, :user_id => user_ids})
    @clocked_in.each { |entry| @clocked_in_ids << entry.user_id } if @clocked_in
  end

end
