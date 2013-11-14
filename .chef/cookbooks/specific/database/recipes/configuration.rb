
# Automated mySQL backups every 30 minutes
template "/root/mysql-backup.sh" do
  source "mysql-backup.sh.erb"
  mode 0777
  owner "root"
  group "root"
  variables({
     :server_root_password => node['mysql']['server_root_password']
  })
end

cron "mysql-dump-database" do
  minute "*/30*"
  command "/root/mysql-backup.sh"
end
 
# Add remote access for root user
execute "mysql-remote-access" do
	command "mysql -u root -p#{node['mysql']['server_root_password']} -e \"GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '#{node['mysql']['server_root_password']}' WITH GRANT OPTION\"";
end
