name "web"
description "A basic database server"


# Runlist
run_list(
	
	# MySQL
	"recipe[mysql::server]",

	"recipe[database::configuration]"
)


# Attributes
override_attributes(
  "mysql" => {
    "server_root_password" => "root",
    "server_repl_password" => "",
    "server_debian_password" => "",
    "root_network_acl" => "10.0.2.2"
  }
)