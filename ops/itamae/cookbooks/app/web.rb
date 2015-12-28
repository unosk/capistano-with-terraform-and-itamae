include_recipe './_common.rb'

# unicorn

node.validate! do
  {
    unicorn: {
      processes: integer,
      timeout: optional(integer)
    }
  }
end
node[:unicorn][:timeout] ||= 30

template '/etc/init.d/unicorn' do
  mode '755'
  variables(
    app_root: File.join(node[:app][:deploy_to], 'current'),
    app_user: node[:app][:deploy_as],
    app_environment: node[:app][:environment],
    processes: node[:unicorn][:processes],
    timeout: node[:unicorn][:timeout]
  )
end

execute 'update-rc.d' do
  command 'update-rc.d unicorn defaults'
  not_if 'ls /etc/rc2.d | grep unicorn'
end

# nginx

include_recipe '../nginx/default.rb'

link '/etc/nginx/sites-enabled/app' do
  to '/etc/nginx/sites-available/app'
end

template '/etc/nginx/sites-available/app' do
  variables(
    root: File.join(node[:app][:deploy_to], 'current/public'),
    unicorn_socket: File.join(node[:app][:deploy_to], 'shared/tmp/sockets/unicorn.sock')
  )
  notifies :restart, 'service[nginx]'
end

# monit

include_recipe '../monit/default.rb'

monit 'unicorn' do
  pidfile File.join(node[:app][:deploy_to], 'shared/tmp/pids/unicorn.pid')
end

# logrotate

template '/etc/logrotate.d/unicorn' do
  variables(
    log_file: File.join(node[:app][:deploy_to], 'shared/log/unicorn.log'),
    app_user: node[:app][:deploy_as]
  )
end
