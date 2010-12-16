class Private::MaterialReportSummariesController < ApplicationController
  layout "private", :except => "print"
  filter_access_to :all

  def index
    @page_title = "Material Report Summaries"
    @jobs = Job.active
  end

  def show
    @page_title = "Material Report Summary for Job #{params[:job_id]}"
    @job = Job.find(params[:job_id], :include => [:gun_sheets,:load_sheets])
  end

end
