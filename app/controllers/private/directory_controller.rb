class Private::DirectoryController < ApplicationController

  layout "private"
  filter_access_to :all

  def index
    @users = User.find(:all, :order => "last_name ASC", :conditions => {:employment_state => "Employed"})
  end

end