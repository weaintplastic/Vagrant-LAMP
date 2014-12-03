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
2. Clone this repository to a folder anywhere on your computer (e.g. your user directory) and give it a self explaining name (e.g. Vagrant). Please make sure that you also checkout all submodules.
3. Use your command line tool and navigate to this folder and execute the following statement
``vagrant up``
Your Vagrant environment will now be created by first downloading the base box precise32. After that process the skeleton of your virtual machine is setup and ready to proceed with installing all necessary packages and libraries.
5. Execute the following statement on your command line to install all packages and libraries
``vagrant provision``
This will install packages and libraries one by another to get a fully working web server environment. This may take a while.
6. Now your server environment is set up correctly and is ready to use.
7. To make sure all services are working and booted correctly, you may need to restart your Vagrant environment by executing ``vagrant reload`` on your command line.

## How to use

### Setup Virtual Hosts
Each of your web projects deserves its own host. The creationg of a virtual host is pretty easy.

#### 1. Add Vagrant configuration

Therefore navigate to the folder .chef/databags/sites. There you will see the configuration of the default site called *loop.local*. To add your own virtual hosts copy the *loop.local.json* file and customize it for your own needs

{
    "id": "your-site", #a unique id
    "host": "your-site.local", #the hosts dns
    "aliases": [
    "loop.local.192.168.1.164.xip.io" #any alias you wanna use
    ]
}

This configuration will tell your server to create a virtual host that you'll be able to access through the URL `http://your-site.local`. For testing your website on different browsers and devices you should also add an alias to your virtual host configuration using [xip.io](http://xip.io) following this format your-site.local.**192.168.1.164**.xip.io while *your-site.local* is the URL of your virtual hoste and *192.168.1.164* should be replaced by the IP of your workstation.

To make your virtual development environment set up the virtual host for you, you need to kick off the Vagrant provisioning process once again.

vagrant provision

After executing this command your virtual host was created properly.

#### 2. Update host configuration

But before this host is accessible from your host (workstation) you need to update the `host` configuration located at *C:/Windos/system32/drivers/etc/host* on Windows machines or */etc/host* on Mac OS.

Add the following entry

127.0.0.1		your-site.local
::1             your-site.local

Note that you need administration rights to change theses files.

### Database

To connect to the database of your virtual server environment you should use a tool like [HeidiSQL](http://www.heidisql.com/) for Windows or [SequelPro](http://www.sequelpro.com/)

Your MySQL server is accesible with the following configuration:


    host: 127.0.0.1
    user: root
    password: root


### Log-Files

Each of your virtual hosts has its own dedicated log files located at */var/log/apache2*. There you can find access, rewrite and error logs like yourhostname-acccess.log, yourhostname-rewrite.log or yourhostname-error.log

### Mail

This Vagrant installation has a built in maildemon [Mailcatcher](http://mailcatcher.me/) for you to debug mail sending using PHP. Therefore hit the URL http://localhost:1080. The interface shows you a virtual mailbox which gathers all mails sent with sendmail. You can give it a try by loading http://loop.local/mail.php.

### Backups

This Vagrant installation automatically does backups of your whole database every half hour. You can find the dumps located at */backup/db*


### Port-forwarding on Mac OS

Since Mac OS doesn't allow lower number port forwarding you have to do the following changes on the Vagrant File to make it work.

config.vm.network :forwarded_port, guest: 80, host: 8080


After that please execute the following statement on your command line.
This statement has to be executed everytime you are booting your system.

$ sudo ipfw add 100 fwd 127.0.0.1,8080 tcp from any to me 80


To make this changes happen everytime you reboot your system automatically, please follow the instructions by dmuth:
(http://www.dmuth.org/node/1404/web-development-port-80-and-443-vagrant)

You also need a special fix for VirtualBox to allow Port Forwarding on lower ports:
http://frontiernxt.com/port-forwarding-small-port-numbers-with-vagrant-on-os-x
