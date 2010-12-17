class Private::ReportSummariesController < ApplicationController
  layout "private", :except => "print"
  filter_access_to :all

  def index
    @page_title = "Summary Reports"
    @jobs = Job.active
  end

end