class Private::ReportSummariesController < ApplicationController
  layout "private", :except => "print"
  filter_access_to :all

  def index
    @page_title = "Summary Reports"
    @jobs = Job.active
<<<<<<< HEAD
    
    @search = Job.active.search(params[:search])
    
    if params[:commit] == "Search"
      @jobs = @search.all
=======

    @search = Job.search(params[:search])
    if params[:commit] == "Search"
      @jobs = @search
>>>>>>> 47997ff1564b43ec7da48d71469d64fa72e6a29d
    end
  end

  def all_job_value
    @page_title = "All Job Value"
    @jobs = Job.active
  end

  def all_marking_value
    @page_title = "All Marking Value"

    @groups = GunMarkingGroup.all

    @category_groups = []

    @groups.each do |group|
      @category_groups << GunMarkingCategory.categories_for_group(group.id)
    end
  end

end
