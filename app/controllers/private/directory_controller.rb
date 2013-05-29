class Private::DirectoryController < ApplicationController

  layout "private"
  filter_access_to :all

  def index
    @users = User.where(:employment_state => 'Employed').order('last_name ASC')
  end

end
