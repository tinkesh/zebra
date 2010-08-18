class Private::MaterialReportsController < ApplicationController

  layout "private"
  filter_access_to :all

  def index
    @material_reports = MaterialReport.find(:all, :order => 'id DESC', :include => [:job, :gun_sheets, :load_sheets])
    @page_title = "Material Reports"
  end

  def show
    @material_report = MaterialReport.find(params[:id], :include => [:load_sheets, :gun_sheets])
    @page_title = @material_report.label
    @job_marking_cats = Array.new
    @gun_sheets = @material_report.gun_sheets
    @load_sheets = @material_report.load_sheets
  end

  def new
    @job = Job.find(params[:job_id])
    @load_sheets = LoadSheet.find(:all)
    @material_report = MaterialReport.new
    @material_report.created_by= current_user.id
    @page_title = "New Material Report for #{@job.label}"
  end

  def create
    @job = Job.find(params[:job_id])
    @material_report = @job.material_reports.build(params[:material_report])
    @material_report.created_by= current_user.id
    if @material_report.save
      flash[:notice] = "Material Report created!"
      redirect_to private_material_report_url(@material_report)
    else
      render :action => :new
    end
  end

  def edit
    @material_report = MaterialReport.find(params[:id])
    @load_sheets = LoadSheet.find(:all)
    @job = Job.find(@material_report.job_id)
    @page_title = "Edit Material Report #{@material_report.id}"
  end

  def update
    @material_report = MaterialReport.find(params[:id])
    if @material_report.update_attributes(params[:material_report])
      flash[:notice] = "Material Report updated!"
      redirect_to private_material_report_url(@material_report)
    else
      render :action => :edit
    end
  end

  def destroy
    @material_report = MaterialReport.find(params[:id])
    @material_report.destroy
    flash[:notice] = 'Material Report deleted!'
    redirect_to(private_material_reports_url)
  end

end