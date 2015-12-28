namespace :unicorn do
  %w(start stop restart upgrade).each do |action|
    desc "Unicorn #{action}"
    task action do
      on roles(:app) do
        if test("[ -d #{current_path} ]")
          sudo :service, :unicorn, action
        end
      end
    end
  end

  %w(monitor unmonitor).each do |action|
    desc "Unicorn #{action}"
    task action do
      on roles(:app) do
        if test("[ -d #{current_path} ]")
          sudo :monit, action, :unicorn
        end
      end
    end
  end
end
