class Private::ReconciliationSummariesController < ApplicationController
  layout "private", :except => "print"
  filter_access_to :all

  def index
    @page_title = "Reconciliation Summaries"
    @jobs = Job.active
  end

  def show
    @page_title = "R. Summary"
    @job = Job.find(params[:job_id], :include => [:job_markings, :gun_sheets])
  end

end
