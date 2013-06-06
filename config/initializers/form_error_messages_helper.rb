class ActionView::Helpers::FormBuilder
  def error_messages
    return unless object.respond_to?(:errors) && object.errors.any?

    object.errors.full_messages.map { |message| @template.content_tag(:div, message, :class => 'error') }.join('').html_safe
  end
end
