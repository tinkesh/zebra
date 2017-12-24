class Private::ProductReportsController < ApplicationController

  layout "private"
  filter_access_to :all

  def new
  	@page_title = "New Product Report"
    if params[:job_id].present?
    	@job = Job.find(params[:job_id])
    	@product_report = ProductReport.new #:job_id => @job.id
    	#@product_report.created_by = current_user.id
    else

    end
  end
end
