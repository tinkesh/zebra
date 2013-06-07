class Private::ClockOutController < ApplicationController

  layout "private"
  filter_access_to :all

  def new
    build_crew_and_users

    @clocked_in = TimeEntry.where(:active => true, :time_sheet_id => nil, :clock_out => nil, :user_id => @users)

    started_on = begin
      @clocked_in.first.clock_in.change(:hour => Time.zone.now.hour, :min => Time.zone.now.min) # Set started_on to clocked_in date but with the current time
    rescue
      Time.zone.now
    end

    @job = Job.new
    @job.started_on = Time.at(started_on.to_i/(15*60)*(15*60)) # Rounded down to the nearest 15 minutes

    @entries = TimeEntry.where(:time_sheet_id => nil, :user_id => @users)
    @page_title = "Clock Out"
  end

  def create
    if in_mobile_view?
      @clock_out_time = params[:job][:'started_on(1i)'] + '-' + params[:job][:'started_on(2i)'] + '-'+ params[:job][:'started_on(3i)'] + ' ' + params[:job][:'started_on(4i)'] + ':' + params[:job][:'started_on(5i)'] + ":00"
    else
      @clock_out_time = params[:job][:started_on]
    end

    if params[:users]
      params[:users].each do |user|
        @entry = TimeEntry.where(:user_id => user, :clock_out => nil, :time_sheet_id => nil).first
        if @entry
          if @entry.active
            @entry.clocked_out_by = current_user.id
            @entry.clock_out = Time.zone.parse(@clock_out_time)
            @entry.clocked_out_at = Time.zone.now
          end
          @entry.save
        end
      end
    end

    if params[:navigate]
      case params[:navigate]
        when "clock_in" then @redirect = url_for :controller => "private/clock_in",  :action => "new"
        when "clock_out" then @redirect = url_for :controller => "private/clock_out", :action => "new"
        when "home" then @redirect = url_for private_home_path
        when "new_time_sheet" then @redirect = url_for new_private_time_sheet_path
      end
      flash[:notice] = "Users clocked out!"
      redirect_to @redirect
    else
      redirect_to :controller => 'private/clock_out', :action => :new
    end

  end

private

  def build_crew_and_users

    @crew = current_user.try(:crew)
    user_ids = []

    if @crew
      @users = @crew.users
      @crew.users.each {|user| user_ids << user.id}
    else
      @users = User.where(:employment_state => "Employed")
      @users.each { |user| user_ids << user.id }
    end
  end

end
