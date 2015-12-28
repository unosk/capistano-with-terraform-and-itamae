node.validate! do
  {
    newrelic: {
      license_key: string
    }
  }
end

apt_key '548C16BF'

file '/etc/apt/sources.list.d/newrelic.list' do
  content 'deb http://apt.newrelic.com/debian/ newrelic non-free'
  notifies :run, 'execute[apt-get update]', :immediately
end

package 'newrelic-sysmond'

template '/etc/newrelic/nrsysmond.cfg' do
  owner 'newrelic'
  group 'newrelic'
  mode '0640'
  variables(
    license_key: node[:newrelic][:license_key]
  )
  notifies :restart, 'service[newrelic-sysmond]'
end

service 'newrelic-sysmond' do
  action [:enable, :start]
end

# monit

include_recipe '../monit/default.rb'

monit 'newrelic-sysmond' do
  pidfile '/var/run/newrelic/nrsysmond.pid'
end
