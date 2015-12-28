lock '3.4.0'

set :application, 'exampleapp'
set :deploy_to, "/opt/#{fetch(:application)}"
set :repo_url, 'git@bitbucket.org:unosk/exampleapp.git'
set :branch, 'master'
set :scm, :git

set :linked_dirs, %w(log tmp/pids tmp/cache tmp/sockets vendor/bundle public/uploads)

set :format, :pretty
set :log_level, :info

# dotenv
after 'deploy:updating',  'dotenv:upload'

# unicorn
after 'deploy:updated',   'unicorn:unmonitor'
after 'deploy:published', 'unicorn:upgrade'
after 'deploy:published', 'unicorn:monitor'

# sidekiq
after 'deploy:starting',  'sidekiq:quiet'
after 'deploy:updated',   'sidekiq:unmonitor'
after 'deploy:updated',   'sidekiq:stop'
after 'deploy:reverted',  'sidekiq:stop'
after 'deploy:published', 'sidekiq:start'
after 'deploy:published', 'sidekiq:monitor'
