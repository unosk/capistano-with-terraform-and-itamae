include_recipe './_common.rb'

# sidekiq

node.validate! do
  {
    sidekiq: {
      concurrency: integer,
      timeout: optional(integer)
    }
  }
end
node[:sidekiq][:timeout] ||= 60

template '/etc/init.d/sidekiq' do
  mode '755'
  variables(
    app_root: File.join(node[:app][:deploy_to], 'current'),
    app_user: node[:app][:deploy_as],
    app_environment: node[:app][:environment],
    concurrency: node[:sidekiq][:concurrency],
    timeout: node[:sidekiq][:timeout]
  )
end

execute 'update-rc.d' do
  command 'update-rc.d sidekiq defaults'
  not_if 'ls /etc/rc2.d | grep sidekiq'
end

# monit

include_recipe '../monit/default.rb'

monit 'sidekiq' do
  pidfile File.join(node[:app][:deploy_to], 'shared/tmp/pids/sidekiq.pid')
end

# logrotate

template '/etc/logrotate.d/sidekiq' do
  variables(
    log_file: File.join(node[:app][:deploy_to], 'shared/log/sidekiq.log'),
    app_user: node[:app][:deploy_as]
  )
end
