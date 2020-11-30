resource_manifest_version 'cerulean'

author 'Adrian Cedres'
description 'Police table with using in ESX. You are can controlled many'
version '0.1'

ui_page ("html/index.html")

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    '@es_extended/locale.lua',
    'server/server.lua'
}


client_scripts {
    '@es_extended/locale.lua',
    'client/main_client.lua'
}

files{
    "html/index.html",
    "html/index.js",
    "html/style/main.css",
    "html/style/reset.css",
    "html/image/LSPD.png"
}

