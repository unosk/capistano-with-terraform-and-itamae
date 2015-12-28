package 'monit'

template '/etc/monit/monitrc' do
  owner 'root'
  group 'root'
  notifies :restart, 'service[monit]'
end

service 'monit' do
  action [:enable, :start]
end

define :monit, pidfile: nil, start_program: nil, stop_program: nil, policies: [] do
  name = params[:name]
  pidfile = params[:pidfile]
  start_program = params[:start_program] || "/etc/init.d/#{name} start"
  stop_program = params[:stop_program] || "/etc/init.d/#{name} stop"
  policies = params[:policies]

  template "/etc/monit/conf.d/#{name}.conf" do
    owner 'root'
    group 'root'
    source './templates/etc/monit/conf.d/template.erb'
    variables(
      name: name,
      pidfile: pidfile,
      start_program: start_program,
      stop_program: stop_program,
      policies: policies
    )
    notifies :reload, 'service[monit]'
  end
end
