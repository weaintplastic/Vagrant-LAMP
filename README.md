Vagrant-LAMP
============

This is a basic Vagrant setup for a LAMP (Linux-Apache-MySQL) server. It contains basic packages and libraries for everyday web development ready for you to use.

## What's inside?

This Vagrant configuration is based on the basebox precise32 and includes all packages and libraries to set up a proper web server.

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


#### Database

* mysql
* mysql::server

## Installation

1. Download and install [VirtualBox](https://www.virtualbox.org/)  and [Vagrant](http://www.vagrantup.com/) 
2. Clone this repository to a folder anywhere on your computer (e.g. your user directory) and give it a self explaining name (e.g. Vagrant)
3. Use your command line tool and navigate to this folder
4. Exectue the following statement
``vagrant up``
Your Vagrant environment will now be created by first downloading the base box precise32. After that process your skeleton of your virtual machine is setup and ready to proceed with installing all necessary packages and libraries
5. Exectue the following statement to install all packages and libraries
``vagrant provision``
This will install packages and libraries one by one to get a fully working web server environment. This may take a while, so get yourself a coffee.
6. Now your server environment is set up correctly and ready to use.

## How to use

### Virtual Hosts
Each of your web projects deserves its own host. Therefore you can create virtual hosts pretty easy. Therefore navigate to the folder .chef/databags/sites. There you will see the configuration of the default site called ''loop.local''. To add your own virtual hosts copy the ''loop.local.json'' file and customize it for your own needs

``{
    "id": "loop", #a unique id
    "host": "loop.local", #the hosts dns
    "aliases": [
        "loop.local.192.168.1.164.xip.io" #any alias you wanna use
    ]
}``

Your virtual hosts will just be created during the provisioning process. So if you create a new virtual host with this file, run the following statement in your command line tool:

``vagrant provision``

Doing that, a new virtual host will be created in your virtual server environment

Each of your web projects has its own folder in ''/public'' with the exact name of its dns you configured using the ''json'' file.

To make your virtual host accessible you just have to add its dns to your system hosts file located at C:/Windos/system32/drivers/etc/host on Windows machines or //etc/host on Mac OS. Add the following entry

``127.0.0.1		loop.local
::1             loop.local``

Check if your new created host is working hitting its url in a browser of your choice (e.g. http://loop.local)

### Database

To connect to the database of your virtual server environment you should use a tool like [HeidiSQL](http://www.heidisql.com/) for Windows or [SequelPro](http://www.sequelpro.com/)

Your MySQL server is accesible with the following configuration:

``
host: 127.0.0.1
user: root
password: root
``

### Mail

This Vagrant installation has a built in maildemon [Mailcatcher](http://mailcatcher.me/) for you to debug mail sending using PHP. Therefore hit the URL http://localhost:1080. The interface shows you a virtual mailbox which gathers all mails sent with sendmail. You can give it a try by loading http://loop.local/mail.php. 

### Backups

This Vagrant installation automatically does backups of your whole database every half hour. You can find the dumps located at ''/backup/db''



