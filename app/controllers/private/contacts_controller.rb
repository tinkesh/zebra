class Private::ContactsController < ApplicationController

  layout "private"
  filter_access_to :all, :context => :admin

  def index
  end

end