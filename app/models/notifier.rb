class Notifier < ActionMailer::Base
  default_url_options[:host] = "aaastriping.ca"

  def password_reset_instructions(user)
    subject       "[AAAS] Password Reset"
    from          "notifier@aaastriping.ca"
    recipients    user.email
    sent_on       Time.now
    body          :edit_password_reset_url => edit_password_reset_url(user.perishable_token)
  end

  def new_time_sheet(time_sheet)
    subject       "[AAAS] New Time Sheet ##{time_sheet.id}"
    from          "notifier@aaastriping.ca"
    recipients    "dana@agilestyle.com"
    sent_on       Time.now
    body          :time_sheet => time_sheet
  end

  def new_load_sheet(load_sheet)

  end

  def new_gun_sheet(gun_sheet)

  end

end