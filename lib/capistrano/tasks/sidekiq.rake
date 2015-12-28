namespace :sidekiq do
  %w(start stop quiet restart).each do |action|
    desc "Sidekiq #{action}"
    task action do
      on roles(:worker) do
        if test("[ -d #{current_path} ]")
          sudo :service, :sidekiq, action
        end
      end
    end
  end

  %w(monitor unmonitor).each do |action|
    desc "Sidekiq #{action}"
    task action do
      on roles(:app) do
        if test("[ -d #{current_path} ]")
          sudo :monit, action, :sidekiq
        end
      end
    end
  end
end
