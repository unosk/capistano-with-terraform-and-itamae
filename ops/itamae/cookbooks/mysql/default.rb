package 'mysql-server-5.6'

template '/etc/mysql/conf.d/utf8mb4.cnf' do
  notifies :restart, 'service[mysql]'
end

service 'mysql' do
  action [:enable, :start]
end

# monit

include_recipe '../monit/default.rb'

monit 'mysql' do
  pidfile '/var/run/mysqld/mysqld.pid'
end
