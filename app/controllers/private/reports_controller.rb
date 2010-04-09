class Private::ReportsController < ApplicationController

  layout "private"
  filter_access_to :all

  def user_time
    @date = Time.now
    if @date.day <= 23
      @back  = Time.now.year.to_s + "-" + (Time.now.month - 1).to_s + "-" + "24"
      @front = Time.now.year.to_s + "-" + Time.now.month.to_s + "-" + "24"
    else
      @front = Time.now.year.to_s + "-" + Time.now.month.to_s + "-" + "24"
      @back  = Time.now.year.to_s + "-" + (Time.now.month + 1).to_s + "-" + "24"
    end

    @entries = TimeEntry.find(:all, :conditions => {:clock_in => @back.to_date...@front.to_date, :user_id => current_user.id}, :order => "created_at ASC")
  end

end