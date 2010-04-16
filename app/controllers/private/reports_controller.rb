class Private::ReportsController < ApplicationController

  layout "private"
  before_filter :load_user, :only => [:user_time]
  before_filter :kickout, :only => :user_time

  filter_access_to :all

  def user_time
    session[:report] = "user_time"
    if session[:offset].blank? : session[:offset] = Time.now end
    @date = session[:offset]
    generate_front_to_back
    @entries = TimeEntry.find(:all,
      :conditions => { :clock_in => @back.to_date...@front.to_date, :user_id => params[:id] },
      :order => "created_at ASC")
  end

  def time_entries
    session[:report] = "time_entries"
    if session[:offset].blank? : session[:offset] = Time.now end
    @date = session[:offset]
    generate_front_to_back
    @entries = TimeEntry.find(:all,
      :conditions => { :clock_in => @back.to_date...@front.to_date },
      :order => "created_at ASC",
      :include => [:job, :user, :time_sheet])
  end

  def increase_offset
     session[:offset] += 1.months
     redirect_to :action => session[:report], :id => params[:id]
  end

  def decrease_offset
    session[:offset] -= 1.months
    redirect_to :action => session[:report], :id => params[:id]
  end

  def reset_offset
    session[:offset] = Time.now
    redirect_to :action => session[:report], :id => params[:id]
  end

private

  def generate_front_to_back
    if @date.day <= 23
      @back  = @date.year.to_s + "-" + (@date.month - 1).to_s + "-" + "24"
      @front = @date.year.to_s + "-" + @date.month.to_s + "-" + "24"
    else
      @front = @date.year.to_s + "-" + @date.month.to_s + "-" + "24"
      @back  = @date.year.to_s + "-" + (@date.month + 1).to_s + "-" + "24"
    end
  end

  def load_user
    @user = User.find(params[:id])
  end

  def kickout
    unless params[:id] == current_user.id || current_user.role_symbols.include?(:admin) || current_user.role_symbols.include?(:office)
      redirect_to :action => :user_time, :id => current_user.id
    end
  end

end