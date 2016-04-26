ActionMailer::Base.delivery_method = :smtp

if Rails.env.production?
  # Use SendGrid
  ActionMailer::Base.smtp_settings = {
    :address        => 'smtp.sendgrid.net',
    :port           => '587',
    :authentication => :plain,
    :user_name      => ENV['SENDGRID_USERNAME'],
    :password       => ENV['SENDGRID_PASSWORD'],
    :domain         => 'heroku.com',
    :enable_starttls_auto => true
  }
else
  # Use MailCatcher http://mailcatcher.me/
  ActionMailer::Base.smtp_settings = {
    :address => 'localhost',
    :port => 1025
  }
end
