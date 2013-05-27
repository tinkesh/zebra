AaaStriping::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # Provides additional information in stack traces
  config.consider_all_requests_local = true

  # Raise exceptions instead of rendering exception templates
  config.action_dispatch.show_exceptions = false

  # Reload application code on every request
  config.cache_classes = false

  # Disable request forgery protection in test environment
  config.action_controller.allow_forgery_protection = false

  # Tell Action Mailer not to deliver emails to the real world.
  # The :test delivery method accumulates sent emails in the
  # ActionMailer::Base.deliveries array.
  config.action_mailer.delivery_method = :test
end
