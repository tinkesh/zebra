# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  # Block method that creates an area of the view that
  # is only rendered if the request is coming from an
  # anonymous user.
  def anonymous_only(&block)
    if !logged_in?
      block.call
    end
  end

  # Block method that creates an area of the view that
  # only renders if the request is coming from an
  # authenticated user.
  def authenticated_only(&block)
    if logged_in?
      block.call
    end
  end

  def active_menu(number)
    'class="active" ' if (@mainmenu == number || @sidebarmenu == number)
  end

  def job_label(job)
    if job
      export = '#' + job.id.to_s
      if job.name : export += ", " + job.name end
    else
      export = "No Job"
    end
    export
  end

  def link_to_remove_fields(name, form)
    form.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)", :class => "delete-inline")
  end

  def link_to_add_fields(name, form, association)
    new_object = form.object.class.reflect_on_association(association).klass.new
    fields = form.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :form => builder)
    end
    link_to_function(name, h("add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")"), :class => "new-inline")
  end

end
