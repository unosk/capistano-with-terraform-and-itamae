execute 'apt-get update' do
  action :nothing
end

execute 'apt-get-update periodic' do
  command 'apt-get update'
  only_if 'test `stat -c %Y /var/lib/apt/periodic/update-success-stamp` -lt `date --date "1 days ago" +%s`'
end

%w(
  software-properties-common
  apt-transport-https
).each do |pkg|
  package pkg
end

# definition

define :apt_key do
  name = params[:name]
  execute "apt-key #{name}" do
    command "apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys #{name}"
    not_if "apt-key list | grep '/#{name} '"
  end
end

define :ppa do
  user, archive = params[:name].split('/')
  execute 'add-apt-repository' do
    command "add-apt-repository -y ppa:#{user}/#{archive}"
    not_if "test -e /etc/apt/sources.list.d/#{user}-#{archive}-trusty.list"
    notifies :run, 'execute[apt-get update]', :immediately
  end
end
