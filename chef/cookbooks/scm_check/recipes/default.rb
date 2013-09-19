pp node[:minitest][:ci_reports]

group 'admins' do
  action :create
end

%w{ kalabiyau wengel }.each do |username|
  user username do
    action :create
    group 'admins'
  end
end

file '/etc/test_me_please' do
  content 'this_should_be_here'
  mode 0600
  owner 'root'
  group 'root'
end

package 'redis' do
  action :install
end

cookbook_file '/etc/redis/default.conf' do
  source 'redis_config.conf'
  mode 0600
  owner 'redis'
  group 'redis'
end

service 'redis' do
  action [:enable, :start]
end
