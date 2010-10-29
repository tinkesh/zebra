class Private::MaterialReportsController < ApplicationController

  layout "private", :except => "print"
  filter_access_to :all

  def index
    @material_reports = MaterialReport.paginate :page => params[:page], :order => 'id DESC', :per_page => 50, :include => [:job, :gun_sheet, :load_sheet]
    @page_title = "Material Reports"
  end

  def show
    @material_report = MaterialReport.find(params[:id], :include => [:load_sheet, :gun_sheet, :job])
    @page_title = @material_report.label
    @job_marking_cats = Array.new
  end

  def print
    @material_report = MaterialReport.find(params[:id], :include => [:load_sheets, :gun_sheets])
    @page_title = @material_report.label
    @job_marking_cats = Array.new
    @gun_sheets = @material_report.gun_sheets
    @load_sheets = @material_report.load_sheets
  end

  def my_edit

    @params = params
    @flag = false

    @params.each do |p|
      if p.length > 1
      if p[0] == "subtract"
        @end = p[1]
      elsif p[0] == "plus"
        @start = p[1]
      elsif p[1] == "Save yellow values"
        @flag = true
        @load_id = p[0]
      elsif p[1] == "Save white values"
        @flag = false
        @load_id = p[0]
      end
    end
    end
      @load = LoadSheet.find(:first, :conditions => { :id => @load_id})

      if @flag
      @load.adjusted_yellow_dip_start  = @start
      @load.adjusted_yellow_dip_stop  = @end
      else
        @load.adjusted_white_dip_start  = @start
        @load.adjusted_white_dip_stop  = @end
      end

      if @load.save
        flash[:notice] = "Material reports sheet has been updated"
      end
    @mat = MaterialReport.find(:first, :conditions=> {:id => params[:id]})
    redirect_to private_material_report_path(@mat.id)

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
    @material_report = MaterialReport.find(params[:id], :include => [:job])
    @load_sheets = LoadSheet.find(:all, :conditions => { :job_id => @material_report.job_id}, :order => 'created_at DESC' )
    @gun_sheets = GunSheet.find(:all, :conditions => { :job_id => @material_report.job_id}, :order => 'created_at DESC' )
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