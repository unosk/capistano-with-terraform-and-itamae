%w(
  timezone
  apt
  monit
  newrelic
  misc
  nginx
  mysql
  redis
  ruby
  app::web
  app::worker
).each do |name|
  cookbook, recipe = name.split('::')
  include_recipe "./cookbooks/#{cookbook}/#{recipe || 'default'}.rb"
end
