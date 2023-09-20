fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Alv'
description 'OX Inventory Repair Table for guns.'
url 'https://alv.gg'
version '1.0.2'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'client/*.lua',
}

server_scripts {
    'server/*.lua'
}

files {
    'locales/*.json'
}
