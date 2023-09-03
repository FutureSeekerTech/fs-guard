<p align="center">
  <img width="240" height="240" src="https://cdn.discordapp.com/attachments/1078837522882367508/1114897951177855059/fstech_logo.png">
</p>

# FS-GUARD

FiveM script untuk mengamankan server event dari Trigger Exploit yang digunakan pada EULEN/RedEngine dan cheat trigger lainnya, dan melakukan auto banned pada player yang menggunakan trigger event pada resource yang telah diprotect dengan FS-GUARD.

## Installation

    1. Download/clone repository ini
    2. Extract/Paste folder repository di folder resource server kalian. Pastikan nama foldernya adalah fs-guard
    3. Pastikan start/ensure fs-guard pada server.cfg setelah qb-core

## Dependency
    1. OXMYSQL

## Penggunaan
    1. Pada resource fs-guard rubah webhook pada sv_core.lua ke discord webhook kalian
    
    2. Pada fxmanifest script yang ingin kalian amankan tambahkan:
    
    '@fs-guard/cl_guard.lua' -> tambahkan dibagian client script dipaling atas/sebelum client script kalian
    '@fs-guard/sv_guard.lua' -> tambahkan dibagian server script dipaling atas/sebelum server script kalian
    
  ![fxmanifest](https://cdn.discordapp.com/attachments/1128226169339265125/1128620015088836608/image.png)

    3. Pada server script kalian tambahkan GuardEventHandler ketika RegisterNetEvent. Terapkan hal ini pada seluruh RegisterNetEvent 
    kalian pada resource yang ingin diamankan

 ![serverscript](https://cdn.discordapp.com/attachments/1128226169339265125/1128621218199785502/image.png)

 ## Notifikasi Discord
 ![notifikasi](https://cdn.discordapp.com/attachments/1128226169339265125/1128622522829635664/image.png)
