desc 'SSH login'
task :ssh do
  server = roles(:all).first

  ssh_options = fetch(:ssh_options) || {}
  ssh_options.merge!(server.ssh_options || {})
  ssh_options[:user] ||= server.user
  ssh_options[:port] ||= server.port
  ssh_options[:keys] ||= server.keys
  ssh_options[:key] = ssh_options[:keys] && ssh_options[:keys].first

  ssh_cmd = 'ssh '
  ssh_cmd << "#{ssh_options[:user]}@" if ssh_options[:user]
  ssh_cmd << "#{server.hostname}"
  ssh_cmd << " -p #{ssh_options[:port]}" if ssh_options[:port]
  ssh_cmd << " -i #{ssh_options[:key]}" if ssh_options[:key]

  Kernel.system ssh_cmd
end
