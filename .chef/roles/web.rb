name "web"
description "A basic web server"


# Runlist
run_list(
	
	# Common
	"recipe[memcached]",
  	"recipe[imagemagick]",

	# Apache
	"recipe[apache2]",
	"recipe[apache2::mod_fastcgi]",
	"recipe[apache2::mod_rewrite]",
	"recipe[apache2::mod_deflate]",
	"recipe[apache2::mod_expires]",
	"recipe[apache2::mod_headers]",
	"recipe[apache2::mod_env]",
	"recipe[apache2::mod_setenvif]",
	"recipe[apache2::mod_alias]",
	"recipe[apache2::mod_auth_basic]",
	"recipe[apache2::mod_dir]",
	"recipe[apache2::mod_ssl]",
	"recipe[apache2::mod_php5]",

	# NodeJS
	#{}"recipe[nodejs]",
	#{}"recipe[nodejs::npm]",

	# PHP
	"recipe[php]",
	"recipe[php::module_apc]",
	"recipe[php::module_memcache]",
	"recipe[php::module_curl]",
	"recipe[php::module_gd]",
	#"recipe[php::module_sqlite3]",
	"recipe[php::module_mysql]",

	#MCrypt
	"recipe[php-mcrypt]",

	#XDebug
	#"recipe[xdebug]",

	# Setup / Confugration
	"recipe[web::configuration]",
	"recipe[web::setup]"
)