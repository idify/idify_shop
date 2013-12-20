require "bundler/capistrano"

server = "50.116.56.223" 

set :application, "IdifyShop"
set :repository,  "git@github.com:idify/idify_shop.git"

# via the :deploy_to variable:
set :deploy_to, "/var/www/#{application}"
 
# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :git 
set :deploy_via, :remote_cache
set :branch, "master"
 
set :passenger_conf, true
set :user, "root" # Login as?
set :use_sudo, false
set :current_release, release_path
 
 
role :web, server                          # Your HTTP server, Apache/etc
role :app, server                          # This may be the same as your `Web` server
role :db,  server, :primary => true        # This is where Rails migrations will run
#role :db,  "your slave db-server here"
 
set :rails_env, "production"
 
# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts
 
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end