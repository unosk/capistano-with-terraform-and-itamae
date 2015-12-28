%w(
  wget
  curl
  git
).each do |pkg|
  package pkg
end

# monit

include_recipe '../monit/default.rb'

monit 'ssh' do
  pidfile '/var/run/sshd.pid'
end

monit 'cron' do
  pidfile '/var/run/crond.pid'
end
