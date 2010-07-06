# set :application, "aaastriping.ca"
# set :repository,  "git@github:aaastriping.ca.git"
# set :user, "deploy"
# set :deploy_via, :remote_cache
# set :scm, :git

# Customise the deployment

# set :keep_releases, 3
# after "deploy:update", "deploy:cleanup"
# after "deploy:symlink", "deploy:update_crontab"

# directories to preserve between deployments
# set :asset_directories, ['public/system/logos', 'public/system/uploads']

# re-linking for config files on public repos
# namespace :deploy do
#   desc "Update the crontab file"
#   task :update_crontab, :roles => :db do
#     run "cd #{release_path} && whenever --update-crontab #{application}"
#   end
#   desc "Re-link config files"
#   task :link_config, :roles => :app do
#     run "ln -nsf #{shared_path}/config/database.yml #{current_path}/config/database.yml"
#   end
# end