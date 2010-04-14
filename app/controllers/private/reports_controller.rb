class Private::ReportsController < ApplicationController

  layout "private"
  filter_access_to :all

#  before_filter :create_offset

  def user_time

    session[:report] = "user_time"
    if session[:offset].blank? : session[:offset] = Time.now end
    @date = session[:offset]

    if @date.day <= 23
      @back  = @date.year.to_s + "-" + (@date.month - 1).to_s + "-" + "24"
      @front = @date.year.to_s + "-" + @date.month.to_s + "-" + "24"
    else
      @front = @date.year.to_s + "-" + @date.month.to_s + "-" + "24"
      @back  = @date.year.to_s + "-" + (@date.month + 1).to_s + "-" + "24"
    end
    @entries = TimeEntry.find(:all, :conditions => {:clock_in => @back.to_date...@front.to_date, :user_id => current_user.id}, :order => "created_at ASC")
  end

  def increase_offset
     session[:offset] += 1.months
     redirect_to :action => session[:report]
  end

  def decrease_offset
    session[:offset] -= 1.months
    redirect_to :action => session[:report]
  end

  def reset_offset
    session[:offset] = Time.now
    redirect_to :action => session[:report]
  end

private

  def create_offset

  end

end