class Api::CrewsController < ApplicationController

  filter_access_to :all

  def jobs
    @crew = Crew.find(params[:id])
    @events = @crew.events
        #.where('started_on IS NOT NULL')

    respond_to do |format|
      format.json { render json: @events, root: false }
    end
  end

  def schedule_job
    @event = Event.find_by_id(params[:id])

    if @event.nil?
      @job = Job.find(params[:id])
      @event = @job.events.new(params[:event])
      @event.name = @job.name
      @event.save
    else
      @event.update_attributes(params[:event])
    end


    #@job.update_attributes(params[:job])

    respond_to do |format|
      format.json { render json: @event, root: false }
    end
  end

  def show_selected
    @crews = Crew.where(id: params[:crew_ids])

    @events = []
    @crews.each do |crew|
      @events += crew.events
    end

    respond_to do |format|
      format.json { render json: @events, root: false }
    end
  end
end
