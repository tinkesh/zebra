class Private::ReconciliationSummariesController < ApplicationController
  layout "private", :except => "print"
  filter_access_to :all

  def index
    @page_title = "Reconciliation Summaries"
    @jobs = Job.active
  end

  def show
    @job = Job.find(params[:id], :include => [:job_markings, :gun_sheets])
  end

end
