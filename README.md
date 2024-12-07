# UPDATE 7 December 2024
 - Add anti ox lib callback exploit (Join discord for more info)
# UPDATE 24 October 2024

The latest update available, for the detail join discord FutureSeekerTech: https://discord.gg/TRwcswBhg3 or https://futureseekertech.tebex.io/

Video Showcase: https://youtu.be/jwr8_fYO7vs

Current Feature:
- Anti Event Exploit (included with encryption method to make sure communication between client and server is safe. All parameter that send to server event is encrypted to prevent to be readed with event logger).
- Anti Exports Exploit
- Discord Logs With ScreenShot
- Hide Server Event Call Feature. Now you can hide server event call from client to be readed with event logger. You can enable or disable this feature

<p align="center">
  <img width="240" height="240" src="https://alfaritsii.github.io/assets/image/fstech-logo.png">
</p>

# FS-GUARD

FiveM script untuk mengamankan server event dari Trigger Exploit yang digunakan pada EULEN/RedEngine dan cheat trigger lainnya, dan melakukan auto banned pada player yang menggunakan trigger event pada resource yang telah diprotect dengan FS-GUARD.

![preview](https://alfaritsii.github.io/assets/image/fsguard-preview.png)

## Installation

    1. Download/clone repository ini
    2. Extract/Paste folder repository di folder resource server kalian. Pastikan nama foldernya adalah fs-guard
    3. Pastikan start/ensure fs-guard pada server.cfg setelah core framework kalian

## Dependency
    1. OXMYSQL
    2. OX_LIB

## Penggunaan
    1. Pada resource fs-guard rubah webhook pada sv_core.lua ke discord webhook kalian
    
    2. Pada fxmanifest script yang ingin kalian amankan tambahkan:
    
    '@fs-guard/cl_guard.lua' -> tambahkan dibagian client script dipaling atas/sebelum client script kalian
    '@fs-guard/sv_guard.lua' -> tambahkan dibagian server script dipaling atas/sebelum server script kalian
    
  ![fxmanifest](https://alfaritsii.github.io/assets/image/secure-event.png)

    3. Pada server script kalian tambahkan GuardEventHandler ketika RegisterNetEvent. Terapkan hal ini pada seluruh RegisterNetEvent 
    kalian pada resource yang ingin diamankan

    4. Hal ini juga pada client script, kalian tambahkan GuardEventHandler ketika RegisterNetEvent untuk secure client script

 ![serverscript](https://alfaritsii.github.io/assets/image/fxmanifest-fsguard.png)

 ## Notifikasi Discord
 ![notifikasi](https://alfaritsii.github.io/assets/image/notif-fsguard.png)
