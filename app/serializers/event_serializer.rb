class EventSerializer < ActiveModel::Serializer
  attributes :id, :title, :start, :end,
             :url, :backgroundColor, :borderColor, :editable

  def title
    "Crew ##{object.crew.id} - #{object.name}"
  end

  def start
    object.started_on
  end

  def end
    object.completed_on.present? ? object.completed_on : Date.today
  end

  def url
    "/admin/jobs/#{object.eventable_id}"
  end

  def backgroundColor
    "#{object.crew.color}"
  end

  def borderColor
    #object.completion.present? ? object.completion.color : '#3a87ad'
  end

  def editable
    #return false if object.completed?
    true
  end
end
