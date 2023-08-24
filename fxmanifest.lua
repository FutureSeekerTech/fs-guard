fx_version 'adamant'
game 'gta5'
author 'FutureSeeker'
description 'FutureSeeker AC'


shared_scripts {
    'config.lua',
}

client_scripts {
    'cl_core.lua',
    'cl_guard.lua',
}

server_scripts {
    'sv_core.lua',
    -- 'sv_debug.lua',
    'sv_guard.lua',
	'@oxmysql/lib/MySQL.lua',
}
