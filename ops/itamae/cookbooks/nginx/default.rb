ppa 'nginx/stable'

package 'nginx'

template '/etc/nginx/nginx.conf' do
  notifies :restart, 'service[nginx]'
end

file '/etc/nginx/sites-enabled/default' do
  action :delete
end

service 'nginx' do
  action [:enable, :start]
end

# monit

include_recipe '../monit/default.rb'

monit 'nginx' do
  pidfile '/var/run/nginx.pid'
end
