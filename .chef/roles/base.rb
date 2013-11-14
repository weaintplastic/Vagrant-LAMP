name "web"
description "A basic server environment"


# Runlist
run_list(
	"recipe[apt]",
	"recipe[build-essential]",
	"recipe[git]",
	"recipe[zsh]",
	"recipe[openssl]",
	"recipe[curl]",
	"recipe[sqlite]",

	"recipe[base::setup]"
)