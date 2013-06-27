AaaStriping::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  ########################
  ## Heroku Integration
  ########################

  config.log_level = :debug

  config.action_mailer.default_url_options = { :host => "www.zebraonline.ca" }

  config.middleware.use ExceptionNotifier,
    :email_prefix => "[AAAS] ",
    :sender_address => %{"AAAS" <error@aaastriping.com>},
    :exception_recipients => %w{errors@agilestyle.com}
end
