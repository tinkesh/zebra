class Notifier < ActionMailer::Base
  default_url_options[:host] = "www.zebraonline.ca"

  def password_reset_instructions(user)
    subject       "[AAAS] Password Reset"
    from          "notify@aaastriping.ca"
    recipients    user.email
    sent_on       Time.zone.now
    body          :edit_password_reset_url => edit_password_reset_url(user.perishable_token)
  end

  def new_time_sheet(time_sheet)
    subject       "[AAAS] New Time Sheet (##{time_sheet.id})"
    from          "notify@aaastriping.ca"
    recipients    "dorian@aaastriping.ca"
    sent_on       Time.zone.now
    body          :time_sheet => time_sheet
  end

  def new_load_sheet(load_sheet)
    subject       "[AAAS] New Load Sheet (##{load_sheet.id})"
    from          "notify@aaastriping.ca"
    recipients    "dorian@aaastriping.ca"
    sent_on       Time.zone.now
    body          :load_sheet => load_sheet
  end

  def new_gun_sheet(gun_sheet)
    subject       "[AAAS] New Gun Sheet (##{gun_sheet.id}) for #{gun_sheet.job.label}"
    from          "notify@aaastriping.ca"
    recipients    "dorian@aaastriping.ca"
    sent_on       Time.zone.now
    body          :gun_sheet => gun_sheet
  end

  def new_contact(contact)
    subject       "[AAAS] New Contact - #{contact.name}"
    from          "notify@aaastriping.ca"
    recipients    "info@aaastriping.ca"
    sent_on       Time.zone.now
    body          :contact => contact
  end

  def new_career(career)
    subject       "[AAAS] New Employment - #{career.name}"
    from          "notify@aaastriping.ca"
    recipients    "info@aaastriping.ca"
    sent_on       Time.zone.now
    body          :career => career
  end

  def time_sheet_over_hours(time_sheet,hours,user)
    subject       "[AAAS] #{hours} Hours Worked In One Shift"
    from          "notify@aaastriping.ca"
    recipients    "info@aaastriping.ca"
    sent_on       Time.zone.now
    body          :time_sheet => time_sheet, :hours => hours, :user => user
 end

  def time_sheet_many_hours(time_sheet,hours,user)
    subject       "[AAAS] #{hours} Total Worked In One Pay Period"
    from          "notify@aaastriping.ca"
    recipients    "info@aaastriping.ca"
    sent_on       Time.zone.now
    body          :time_sheet => time_sheet, :hours => hours, :user => user
  end

  def job_marking_production_over_expected(marking)
    subject       "[AAAS] #{marking.gun_marking_category.try(:name)} Production higher than Expected"
    from          "notify@aaastriping.ca"
    recipients    "kwame@aaastriping.ca"
    sent_on       Time.zone.now
    body          :marking => marking
  end

end
