class PrivateController < ApplicationController
  
  layout "private"
  filter_resource_access

  def index
  end

end