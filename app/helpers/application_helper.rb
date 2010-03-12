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
      export = 'Job #' + job.id.to_s
      if job.name : export += ", " + job.name end
    else
      export = "No Job"
    end
    export
  end

end
