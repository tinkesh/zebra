require File.expand_path('../boot', __FILE__)
require 'rails/all'

if defined?(Bundler)
  Bundler.require *Rails.groups(:assets => %w(development test))
end

module AaaStriping
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    config.autoload_paths += Dir["#{config.root}/lib", "#{config.root}/lib/**/"]

    # Automatically 'require' everything in lib/
    Dir["lib/*.rb"].each { |path| require_dependency path }

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Only use best-standards-support built into browsers
    config.action_dispatch.best_standards_support = :builtin

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Mountain Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
    # the I18n.default_locale when a translation can not be found)
    config.i18n.fallbacks = true

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password, :password_confirmation, :credit_card, :card_number, :cvc]

    # Prevent mass assignment of paramenters
    config.active_record.whitelist_attributes = true


    #################
    ## Debugging (off, as per Production mode)
    #################

    # This gives us the Called id for nil, which would mistakenly be 4 message.  This will be deprecated soon.
    config.whiny_nils = false

    # Provides additional information in stack traces
    config.consider_all_requests_local = false

    # Reload application code on every request
    config.cache_classes = true

    # Just sent deprecations to stderr
    config.active_support.deprecation = :stderr


    #################
    ## Assets
    #################

    # Enable the asset pipeline
    config.assets.enabled = true

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'

    # MUST be false for Heroku
    config.assets.initialize_on_precompile = false

    # Enables the use of MD5 fingerprints in asset names.  Makes versioned .css/.js work
    config.assets.digest = true

    # Compression is a good thing
    config.assets.compress = true

    # When false, gives us just an application.js/.css  When true it expands them all out
    config.assets.debug = false

    # Compile assets on the fly if a precompiled asset is missed
    config.assets.compile = true

    # Should be true, as we're running our own Rack::Deflator.  Heroku doesn't compress for us anymore
    config.serve_static_assets = true

    # Assets expire after 1-year.  Really, whenever our assets change, the digest invalidates the old ones.
    config.static_cache_control = "public, max-age=31536000"


    #################
    ## Email
    #################

    config.action_mailer.default_url_options = { :host => "appname.com" }

    config.action_mailer.delivery_method = :smtp
    config.action_mailer.default :charset => "utf-8"

    config.action_mailer.perform_deliveries = true
    config.action_mailer.raise_delivery_errors = false


    #################
    ## Caching
    #################

    # Perform caching in general.  This is buggy, setting it to false won't disable caching.
    # If you want to disable caching set the config.cache_store to :null_store
    config.action_controller.perform_caching = true
  end
end

