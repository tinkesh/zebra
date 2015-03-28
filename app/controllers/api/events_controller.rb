class Api::EventsController < ApplicationController
  def jobs
    @crew = Crew.find(params[:id])
    @events = @crew.events #.where('started_on IS NOT NULL')
    render json: @events, each_serializer: EventsSerializer, root: false
  end
end
