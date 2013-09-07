set :application, "pwilson.co"
set :repository,  "git@github.com:PWx21/pwilson.co"

set :deploy_to, "/home/peter/dev"
set :scm, :git
set :branch, "master"
set :user, "peter"

set :rails_env, "production"
set :deploy_via, :copy

set :use_sudo, false
set :ssh_options, { :forward_agent => true }

set :keep_releases, 5
# any password prompts from SSH show up in terminal
default_run_options[:pty] = true

server "pwilson.co", :app, :web, :db, :primary => true

#role :web, "your web-server here"                          # Your HTTP server, Apache/etc
#role :app, "your app-server here"                          # This may be the same as your `Web` server
#role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  desc "Symlink shared config files"
  task :symlink_config_files do
    run "#{ try_sudo } ln -s #{ deploy_to }/shared/config/database.yml #{ current_path }/config/database.yml"
  end
end

after "deploy", "deploy:symlink_config_files"
after "deploy", "deploy:restart"
#after "deploy", "deploy:cleanup"
