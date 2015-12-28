# Capistrano sample with Terraform and Itamae

```
cap bundler:install                # Install the current Bundler environment
cap bundler:map_bins               # Maps all binaries to use `bundle exec` by default
cap deploy                         # Deploy a new release
cap deploy:check                   # Check required files and directories exist
cap deploy:check:directories       # Check shared and release directories exist
cap deploy:check:linked_dirs       # Check directories to be linked exist in shared
cap deploy:check:linked_files      # Check files to be linked exist in shared
cap deploy:check:make_linked_dirs  # Check directories of files to be linked exist in shared
cap deploy:cleanup                 # Clean up old releases
cap deploy:cleanup_assets          # Cleanup expired assets
cap deploy:cleanup_rollback        # Remove and archive rolled-back release
cap deploy:compile_assets          # Compile assets
cap deploy:finished                # Finished
cap deploy:finishing               # Finish the deployment, clean up server(s)
cap deploy:finishing_rollback      # Finish the rollback, clean up server(s)
cap deploy:log_revision            # Log details of the deploy
cap deploy:migrate                 # Runs rake db:migrate if migrations are set
cap deploy:normalize_assets        # Normalize asset timestamps
cap deploy:published               # Published
cap deploy:publishing              # Publish the release
cap deploy:revert_release          # Revert to previous release timestamp
cap deploy:reverted                # Reverted
cap deploy:reverting               # Revert server(s) to previous release
cap deploy:rollback                # Rollback to previous release
cap deploy:rollback_assets         # Rollback assets
cap deploy:set_current_revision    # Place a REVISION file with the current revision SHA in the current release path
cap deploy:started                 # Started
cap deploy:starting                # Start a deployment, make sure server(s) ready
cap deploy:symlink:linked_dirs     # Symlink linked directories
cap deploy:symlink:linked_files    # Symlink linked files
cap deploy:symlink:release         # Symlink release to current
cap deploy:symlink:shared          # Symlink files and directories from shared to release
cap deploy:updated                 # Updated
cap deploy:updating                # Update server(s) by setting up a new release
cap dotenv:upload                  # Upload .env
cap ec2:instance_ids               # Show EC2 instance IDs that match this project
cap ec2:server_names               # Show EC2 server names that match this project
cap ec2:status                     # Show all information about EC2 instances that match this project
cap install                        # Install Capistrano, cap install STAGES=staging,production
cap itamae:apply                   # Itamae apply
cap itamae:plan                    # Itamae plan(dry-run)
cap monit:status                   # Monit status
cap sidekiq:monitor                # Sidekiq monitor
cap sidekiq:quiet                  # Sidekiq quiet
cap sidekiq:restart                # Sidekiq restart
cap sidekiq:start                  # Sidekiq start
cap sidekiq:stop                   # Sidekiq stop
cap sidekiq:unmonitor              # Sidekiq unmonitor
cap ssh                            # SSH login
cap terraform:apply                # Terraform apply
cap terraform:plan                 # Terraform plan(dry-run)
cap unicorn:monitor                # Unicorn monitor
cap unicorn:restart                # Unicorn restart
cap unicorn:start                  # Unicorn start
cap unicorn:stop                   # Unicorn stop
cap unicorn:unmonitor              # Unicorn unmonitor
cap unicorn:upgrade                # Unicorn upgrade
```
