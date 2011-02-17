class Private::ReportSummariesController < ApplicationController
  layout "private", :except => "print"
  filter_access_to :all

  def index
    @page_title = "Summary Reports"
    @jobs = Job.active
  end

  def all_job_value
    @page_title = "All Job Value"
    @jobs = Job.active
  end

  def all_marking_value
    @page_title = "All Marking Value"
  end

end
