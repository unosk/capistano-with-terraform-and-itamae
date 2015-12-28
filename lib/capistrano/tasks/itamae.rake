namespace :itamae do
  desc 'Itamae plan(dry-run)'
  task :plan do
    run_itamae(dry_run: true)
  end

  desc 'Itamae apply'
  task :apply do
    run_itamae(dry_run: false)
  end

  def run_itamae(dry_run: true)
    options = []
    options << "--no-color"
    options << "--dry-run" if dry_run
    options << "--node-json #{node_json}"

    on roles(:all) do |server|
      run_locally do
        with_verbosity Logger::DEBUG do
          execute :bundle, :exec, :itamae, :ssh, *recipe_files, *options, *ssh_options(server)
        end
      end
    end
  end

  def recipe_files
    Array(fetch(:itamae_recipe_files))
  end

  def node_json
    node_json = Tempfile.new('capistrano-node-json')
    node_json.write(fetch(:itamae_attributes).to_json)
    node_json.close
    node_json.path
  end

  def ssh_options(server)
    ssh_options = fetch(:ssh_options) || {}
    ssh_options.merge!(server.ssh_options || {})
    ssh_options[:user] ||= server.user
    ssh_options[:port] ||= server.port
    ssh_options[:keys] ||= server.keys
    ssh_options[:key] = ssh_options[:keys] && ssh_options[:keys].first

    options = []
    options << "--host #{server.hostname}"
    options << "--user #{ssh_options[:user]}" if ssh_options[:user]
    options << "--port #{ssh_options[:port]}" if ssh_options[:port]
    options << "--key #{ssh_options[:key]}" if ssh_options[:key]
  end
end
