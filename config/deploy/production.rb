require 'itamae/secrets'

def secrets
  @secrets ||= Itamae::Secrets('./ops/secrets')
end

set :rails_env, 'production'

#
# Servers
#
set :ec2_access_key_id, -> { secrets[:ops_aws_access_key_id] }
set :ec2_secret_access_key, -> { secrets[:ops_aws_secret_access_key] }
set :ec2_region, %w(ap-northeast-1)

ec2_role :web
ec2_role :app
ec2_role :worker
ec2_role :db

set :ssh_options, lambda {
  ssh_key_file = Tempfile.new('capistrano-ssh')
  ssh_key_file.write(secrets[:ec2_id_rsa])
  ssh_key_file.close
  {
    user: 'ubuntu',
    keys: [ssh_key_file.path]
  }
}

#
# Dotenv
#
set :dotenv, <<EOS
DATABASE_URL=mysql2://root@localhost:3306
REDIS_URL=redis://localhost:6379
AWS_ACCESS_KEY_ID=#{secrets[:app_aws_access_key_id]}
AWS_SECRET_ACCESS_KEY=#{secrets[:app_aws_secret_access_key]}
AWS_REGION=ap-northeast-1
S3_BUCKET=exampleapp
SECRET_KEY_BASE=#{secrets[:secret_key_base]}
NEWRELIC_LICENSE_KEY=#{secrets[:newrelic_license_key]}
EOS

#
# Itamae
#
set :itamae_recipe_files, %w(./ops/itamae/bootstrap.rb)
set :itamae_attributes, lambda {
  {
    app: {
      environment: fetch(:rails_env),
      deploy_to: fetch(:deploy_to),
      deploy_as: 'ubuntu',
      deploy_id_rsa: secrets[:deploy_id_rsa]
    },
    unicorn: {
      processes: 1,
      timeout: 30
    },
    sidekiq: {
      concurrency: 1,
      timeout: 180
    },
    newrelic: {
      license_key: secrets[:newrelic_license_key]
    }
  }
}

#
# Terraform
#
set :terraform_local_path, './ops/terraform'
set :terraform_remote_backend, 's3'
set :terraform_remote_backend_config, lambda {
  {
    bucket: 'exampleapp-ops',
    key: 'production.tfstate',
    access_key: secrets[:ops_aws_access_key_id],
    secret_key: secrets[:ops_aws_secret_access_key],
    region: 'ap-northeast-1'
  }
}
set :terraform_vars, lambda {
  {
    aws_access_key: secrets[:ops_aws_access_key_id],
    aws_secret_key: secrets[:ops_aws_secret_access_key],
    aws_region: 'ap-northeast-1',
    ec2_public_key: secrets[:ec2_id_rsa_pub]
  }
}
