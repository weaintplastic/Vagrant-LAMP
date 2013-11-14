# Install packages
%w{ libsqlite3-dev}.each do |a_package|
  package a_package
end

# Install ruby gems
%w{ rdoc rake mailcatcher }.each do |a_gem|
  gem_package a_gem
end


bash "mailcatcher" do
  code "mailcatcher --ip=0.0.0.0"
  not_if "ps ax | grep -v grep | grep mailcatcher";
end

template "#{node['php']['ext_conf_dir']}/mailcatcher.ini" do
  source "mailcatcher.ini.erb"
  owner "root"
  group "root"
  mode "0644"
  action :create
  notifies :restart, resources("service[apache2]"), :delayed
end