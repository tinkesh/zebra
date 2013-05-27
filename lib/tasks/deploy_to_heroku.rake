task :deploy_setup => :environment do
  @start = Time.now
  puts '===== Setting system variables and adding required addons...'

  system 'heroku maintenance:on'
  system "heroku config:add HEROKU_API_KEY='#{HEROKU_CONFIG[:api_key]}' APP_NAME='#{HEROKU_CONFIG[:appname]}'"
  system "heroku config:add AWS_ACCESS_KEY_ID=#{AMAZON_S3[:access_key_id]} AWS_SECRET_ACCESS_KEY=#{AMAZON_S3[:secret_access_key]} FOG_DIRECTORY=#{AMAZON_S3[:bucket]} FOG_PROVIDER=AWS ASSET_SYNC_GZIP_COMPRESSION=true"
  system 'heroku addons:add memcache'
  system 'heroku labs:enable user-env-compile'
  system 'heroku maintenance:off'

  puts "===== This whole process took #{Time.now - @start} seconds"
end

task :deploy => :environment do
  @remote_name = 'heroku'
  @branch = 'master'

  @start = Time.now
  puts "===== I am going to deploy this application to heroku"
  puts "===== Using: git push #{@remote_name} #{@branch}"

  system "rm -rf public/assets/"
  system 'heroku maintenance:on'
  system "git push #{@remote_name} #{@branch}"
  system 'heroku run rake db:migrate'
  system 'heroku maintenance:off'
  system 'heroku open'

  puts "This whole process took #{Time.now - @start} seconds"
end
