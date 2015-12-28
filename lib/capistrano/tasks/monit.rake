namespace :monit do
  desc 'Monit status'
  task :status do
    on roles :all do
      with_verbosity Logger::DEBUG do
        sudo :monit, :status
      end
    end
  end
end

