class Report < ActiveRecord::Base

  def user
    params[:id]
  end

end
