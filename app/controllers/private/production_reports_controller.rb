class Private::ProductionReportsController < ApplicationController

  layout "private"
  filter_access_to :all

  def new
  	@page_title = "New Product Report"
    if params[:job_id].present?
    	@job = Job.find(params[:job_id])
    	@production_report = ProductionReport.new #:job_id => @job.id
    	#@product_report.created_by = current_user.id
    else

    end
  end


  def create
  	@job = Job.find(params[:job_id])
    @production_report = ProductionReport.new(params[:production_report])
    @production_report.created_by = current_user.id
    @production_report.job_id = @job.id
    if @production_report.save
      redirect_to private_job_url(@job.id)
    else
      redirect_to home_path
    end
  end

  def show
    @job = Job.find(params[:job_id])
    @production_report = ProductionReport.find(params[:id])
  end

  def edit
    @job = Job.find(params[:job_id])
    @production_report = ProductionReport.find(params[:id])
  end

  def update
    @job = Job.find(params[:job_id])
    @production_report = ProductionReport.find(params[:id])
  end
end
