class PrivateController < ApplicationController
  
  layout "private"
  filter_access_to :all

  def index
  end
  
  def settings
    @page_title = "Settings"
  end

end