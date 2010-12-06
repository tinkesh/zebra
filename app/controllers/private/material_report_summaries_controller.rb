class Private::MaterialReportSummariesController < ApplicationController

  layout "private", :except => "print"
  filter_access_to :all

  def index
    @material_report_summaries = MaterialReportSummary.paginate :page => params[:page], :order => 'id DESC', :per_page => 50, :include => [:job]
    @page_title = "Material Report Summaries"
  end

  def show
    @material_report_summary = MaterialReportSummary.find(params[:id], :include => [:gun_sheets, :job])
    @page_title = @material_report_summary.label
    @job_marking_cats = Array.new
  end

  def new
    @job = Job.find(params[:job_id], :include => [:gun_sheets])
    @material_report_summary = MaterialReportSummary.new
    @material_report_summary.user_id = current_user.id
    @page_title = "New Material Report Summary for #{@job.label}"
  end

  def create
    @job = Job.find(params[:job_id])

    params[:material_report_summary] ||= {}
    params[:material_report_summary][:gun_sheet_ids] ||= []
    @material_report_summary = @job.material_report_summaries.build(params[:material_report_summary])
    @material_report_summary.user_id = current_user.id

    if params[:material_report_summary][:gun_sheet_ids] == []
      flash[:error] = "Please select at least one gun sheet"
      render :action => :new
    else
      if @material_report_summary.save
        flash[:notice] = "Material Report created!"
        redirect_to private_material_report_summary_url(@material_report_summary)
      else
        render :action => :new
      end
    end
  end

  def destroy
    @material_report_summary = MaterialReportSummary.find(params[:id])
    @material_report_summary.destroy
    flash[:notice] = 'Material Report Summary deleted!'
    redirect_to(private_material_report_summaries_url)
  end

end
