class ActionView::Helpers::FormBuilder
  def error_messages
    return unless object.respond_to?(:errors) && object.errors.any?

    messages = object.errors.full_messages.join('<br>')
    return @template.content_tag(:div, messages.html_safe, :class => 'error')
  end
end
