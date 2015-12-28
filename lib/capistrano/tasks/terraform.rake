namespace :terraform do
  task :configure do
    options = []
    options << "-backend=#{fetch(:terraform_remote_backend)}"
    options += fetch(:terraform_remote_backend_config).map { |key, value| "-backend-config='#{key}=#{value}'" }
    run_terraform :remote, :config, *options
  end

  desc 'Terraform plan(dry-run)'
  task plan: :configure do
    run_terraform :plan, terraform_vars
  end

  desc 'Terraform apply'
  task apply: :configure do
    run_terraform :apply, terraform_vars
  end

  def run_terraform(*args)
    run_locally do
      within fetch(:terraform_local_path) do
        with_verbosity Logger::DEBUG do
          execute :terraform, *args
        end
      end
    end
  end

  def terraform_vars
    fetch(:terraform_vars).map { |key, value| "-var='#{key}=#{value}'" }
  end
end
