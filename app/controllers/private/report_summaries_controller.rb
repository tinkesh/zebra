class Private::ReportSummariesController < ApplicationController
  layout "private", :except => "print"
  filter_access_to :all

  def index
    @page_title = "Summary Reports"
    @jobs = Job.active

    if params[:query].present?
      @jobs = @jobs.where('jobs.name ilike :query', :query => "%#{params[:query]}%")
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
