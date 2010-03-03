class PrivateController < ApplicationController
  
  layout "private"
  filter_access_to :all

  def index
    @jobs = current_user.jobs
    @page_title = "Dashboard"
  end
  
  def settings
    @page_title = "Settings"
  end

end