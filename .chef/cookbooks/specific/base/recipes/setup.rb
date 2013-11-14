# Creat Ubunut System Autostart Configuration
cookbook_file "/etc/rc.local" do
   	source "rc.local"
   	owner "root"
   	group "root"
   	mode "0755"
	action :create
end