class EventSerializer < ActiveModel::Serializer
  attributes :id, :job_id, :title, :start, :end,
             :backgroundColor, :borderColor, :editable

  def job_id
    object.eventable.id
  end

  def title
    status = object.eventable.completion.present? ? object.eventable.completion.name : 'No Status'
    "Crew ##{object.crew.id} - #{object.name} (#{status})"
  end

  def start
    object.started_on
  end

  def end
    object.completed_on.present? ? object.completed_on : Date.today
  end

  # def url
  #   "/admin/jobs/#{object.eventable_id}"
  # end

  def backgroundColor
    "#{object.eventable.completion.color}"
  end

  def borderColor
    #object.completion.present? ? object.completion.color : '#3a87ad'
  end

  def editable
    #return false if object.completed?
    true
  end
end
