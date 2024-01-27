fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Alv'
description 'OX Inventory Repair Table for guns.'
url 'https://alv.gg'
version '1.0.9'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'client/*.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'discord.lua',
    'server/*.lua'
}

ui_page 'html/index.html'

files {
    'locales/*.json',
    'html/img/*.png',
    'html/index.html',
    'html/style.css',
    'html/script.js'
}
