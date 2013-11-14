# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "precise32"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"

  # Create a forwarded port mapping which allows access to a specific port
  config.vm.network :forwarded_port, guest: 3306, host: 3306
  config.vm.network :forwarded_port, guest: 80, host: 80
  config.vm.network :forwarded_port, guest: 1080, host: 1080

  #config.vm.network :private_network, ip: "192.168.33.10"

  # Set share folder permissions to 777 so that apache can write files
  config.vm.synced_folder ".", "/vagrant", mount_options: ['dmode=777','fmode=666']

  # Provider-specific configuration so you can fine-tune VirtualBox for Vagrant.
  # These expose provider-specific options.
  # VirtualBox Configuration
  config.vm.provider :virtualbox do |provider, config|
      provider.name = "LOOP Development"
      provider.customize ["modifyvm", :id, "--memory", "2048"]
  end

  # Enable provisioning with chef solo, specifying a cookbooks path, roles
  # path, and data_bags path (all relative to this Vagrantfile), and adding
  # some recipes and/or roles.
  config.vm.provision :chef_solo do |chef|
    
    # Configuration
    chef.cookbooks_path = [".chef/cookbooks/generic/", ".chef/cookbooks/specific/"]
    chef.data_bags_path = ".chef/databags"
    chef.roles_path     = ".chef/roles"

    # Roles
    chef.add_role("base")
    chef.add_role("web")
    chef.add_role("database")
    chef.add_role("mail")
  end
end



