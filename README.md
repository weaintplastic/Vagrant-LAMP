Vagrant-LAMP
============

This is a Vagrant setup for a LAMP (Linux-Apache-MySQL) server environment based on Ubuntu. It contains basic packages and libraries for everyday web development ready for you to use.

## What's inside?

This Vagrant configuration is based on the basebox [precise32](https://vagrantcloud.com/ubuntu/boxes/precise32) and includes all packages and libraries to set up a proper web server.

### Basebox
precise32

### Packages and Libraries

#### Server
* apt
* build essentials
* git
* zsh
* openssl
* curl
* sqlite

#### Webserver

* memcached
* imagick

* apache2
* apache2::mod_fastcgi
* apache2::mod_rewrite
* apache2::mod_deflate
* apache2::mod_expires
* apache2::mod_headers
* apache2::mod_env
* apache2::mod_setenvif
* apache2::mod_alias
* apache2::mod_auth_basic
* apache2::mod_dir
* apache2::mod_ssl
* apache2::mod_php5


* php
* php::module_apc
* php::module_memcache
* php::module_curl
* php::module_mysql
* php::module_gd

* php_mcrypt

* xdebug


#### Database

* mysql
* mysql::server

## Installation

1. Download and install [VirtualBox](https://www.virtualbox.org/)  and [Vagrant](http://www.vagrantup.com/)
2. Clone [LOOP's Vagrant box](https://github.com/weaintplastic/Vagrant-LAMP) to a folder anywhere on your computer (e.g. your user directory) and give it a self explaining name (e.g. Vagrant). Please make sure to checkout all git submodules of this repository.
3. Use your command line tool, navigate to this folder and exectue the following statement
``vagrant up``
Your Vagrant environment will now be created by first downloading the base box [precise32](https://vagrantcloud.com/hashicorp/boxes/precise32). After that process the skeleton of your development server environment is setup and your ready to proceed with installing all necessary packages and libraries
4. Exectue the following statement to install all packages and libraries
``vagrant provision``
This will install packages and libraries one by another to get a fully working web server environment. This may take a while, so grab a coffee. When the installation is done, everything should be setup correctly and [ready to use](/docs/Environment/Local_Development_Environment/Vagrant/Getting_started).
5. To make sure all services are booted correctly you should restart your Vagrant environment by executing ``vagrant reload`` on your command line


## How to use

### Setup Virtual Hosts
Each of your web projects deserves its own host. The creation of a virtual host is pretty easy. All you have to do is to follow the next three steps and you are done.

#### 1. Add Vagrant configuration

Navigate to the folder .chef/databags/sites. There you will find the configuration of the default site called *loop.local*. To add your own virtual hosts copy the *loop.local.json* file, rename it to *your-site.local.json* and customize it for your own needs

{
    "id": "your-site", #a unique id
    "host": "your-site.local", #the hosts dns
    "aliases": [
    "your-site.local.192.168.1.164.xip.io" #any alias you wanna use
    ]
}

This configuration will tell your server to create a virtual host that you'll be able to access through the URL `http://your-site.local`. For testing your website on different browsers and devices using [xip.io](http://xip.io), you should also add an alias to your virtual host configuration  following the format your-site.local.**192.168.1.164**.xip.io while *your-site.local* is the URL of your virtual host and *192.168.1.164* should be replaced by the IP of your workstation.

Every time you do changes on the configuration of the server you need to kick off the provisioning process of Vagrant. Once the configuration of your virtual host is done you have to tell Vagrant to finally add this host to it's server environment by executing the following statement on your command line.

vagrant provision

After executing this command your virtual host was created properly.

#### 2. Update host configuration

Before this host is accessible from your system (workstation) you need to update the `host` configuration located at *C:/Windos/system32/drivers/etc/host* on Windows machines or */etc/host* on MacOS.

Add the following entry

127.0.0.1		your-site.local
::1             your-site.local

Note that you need administration rights to change theses files.

#### 3. Create virtual host folder

Vagrant's virtual host expect their webroot to be located in the `public` folder of your Vagrant directory on your system. Create a folder named after the virtual host DNS (e.g. your-site.local) in that directory and create a simple index.html there. If everything was set up correctly you should be able to access the virtual host in your browser via `http://your-site.local`

### Access your Database

To connect to the database of your virtual server environment you should use a tool like [HeidiSQL](http://www.heidisql.com/) for Windows or [SequelPro](http://www.sequelpro.com/)

Your MySQL server is accesible with the following configuration:


host: 127.0.0.1
user: root
password: root

**If have problems accessing your database** usually the mysql server had problems to boot correctly. To fix this please execute `vagrant reload` in your command line. After that you should be able to access the database again.


### Access Log Files

Each of your virtual hosts has its own dedicated log files located at `/var/log/apache2` in your vagrant environment which you are able to access by executing `vagrant ssh` in your command line. There you can find access, rewrite and error logs for any of your v-hosts (e.g. yourhostname-acccess.log, yourhostname-rewrite.log or yourhostname-error.log)



### Keep track of email traffic

This Vagrant installation has a built in maildemon [Mailcatcher](http://mailcatcher.me/) for you to track mail traffic that was sent using PHP. Therefore hit the URL http://localhost:1080. The interface shows you a virtual mailbox which gathers all mails sent with sendmail. You can give it a try by loading http://loop.local/mail.php.


### Backups

This Vagrant installation automatically does backups of your whole database every half hour. You can find the dumps located at `/backup/db` in your Vagrant root directory on your host machine (workstation). If your virtual machine crashes someday you will be prepared to set up any of your host pretty easily.


###  Port-forwarding on Mac OS

#### Yosimeti

http://gielberkers.com/fixing-vagrant-port-forwarding-osx-yosemite/


#### Mavericks

Since Mac OS doesn't allow lower number port forwarding you have to do the following changes on the Vagrant File to make it work.

config.vm.network :forwarded_port, guest: 80, host: 8080


After that please execute the following statement on your command line.
This statement has to be executed everytime you are booting your system.

$ sudo ipfw add 100 fwd 127.0.0.1,8080 tcp from any to me 80


To make this changes happen everytime you reboot your system automatically, please follow the instructions by dmuth:
(http://www.dmuth.org/node/1404/web-development-port-80-and-443-vagrant)

You also need a special fix for VirtualBox to allow Port Forwarding on lower ports:
http://frontiernxt.com/port-forwarding-small-port-numbers-with-vagrant-on-os-x
