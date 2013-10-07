namespace :pg do
  task :pull => :environment do
    @start = Time.now

    puts "===== Capturing backup from Heroku"
    system "`heroku pgbackups:capture --expire`"

    puts "===== Downloading backup"
    system "curl -o latest.dump `heroku pgbackups:url`"

    db = ActiveRecord::Base.configurations
    puts "===== Importing backup into database '#{db[Rails.env]['database']}'"
    system "pg_restore --verbose --clean --no-acl --no-owner -h localhost -U #{db[Rails.env]['username']} -d #{db[Rails.env]['database']} latest.dump"

    puts "This whole process took #{Time.now - @start} seconds"
  end
end

namespace :pg do
  # bundle exec rake pg:save[setup-nicole-tamara.dump]
  task :save, [:file_name] => :environment do |t, args|
    args.with_defaults(:file_name => 'latest.dump')
    db = ActiveRecord::Base.configurations

    puts "===== Saving local database to #{args.file_name}"
    system "pg_dump -Fc --no-acl --no-owner -h localhost -U '#{db[Rails.env]['username']}' '#{db[Rails.env]['database']}' > #{args.file_name}"
  end

  # bundle exec rake pg:load[setup-nicole-tamara.dump]
  task :load, [:file_name] => :environment do |t, args|
    args.with_defaults(:file_name => 'latest.dump')
    db = ActiveRecord::Base.configurations

    puts "===== Loading #{args.file_name} into '#{db[Rails.env]['database']}'"
    system "pg_restore --verbose --clean --no-acl --no-owner -h localhost -U #{db[Rails.env]['username']} -d #{db[Rails.env]['database']} #{args.file_name}"
  end
end

