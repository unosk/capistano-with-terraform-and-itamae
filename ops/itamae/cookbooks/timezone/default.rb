node[:timezone] ||= 'Asia/Tokyo'

execute 'set-timezone' do
  command "timedatectl set-timezone #{node[:timezone]}"
  not_if "timedatectl | grep 'Timezone: #{node[:timezone]}'"
end
