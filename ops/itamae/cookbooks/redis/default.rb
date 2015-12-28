ppa 'chris-lea/redis-server'

package 'redis-server'

service 'redis-server' do
  action [:enable, :start]
end

# monit

include_recipe '../monit/default.rb'

monit 'redis-server' do
  pidfile '/var/run/redis/redis-server.pid'
end
