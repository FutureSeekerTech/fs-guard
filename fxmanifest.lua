fx_version "cerulean"
game "gta5"
author 'FutureSeekerTech'
description 'FS Guard V2'
lua54 'yes'
version '2.3.0'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
}

client_scripts {
    'cl_core.lua',
    'cl_guard.lua',
}

server_scripts {
    'whitelist.lua',
    'webhook.lua',
    'sv_core.lua',
    'sv_guard.lua',
	'@oxmysql/lib/MySQL.lua',
}

dependencies {
    'ox_lib',
    'oxmysql',
}