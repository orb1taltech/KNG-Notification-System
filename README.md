# KNG-Notification-System
Features

Smooth slide-in/out animations
Progress bar that counts down duration
4 notification types: success, error, warning, info
Auto-dismiss after set duration
ESC key closes all
Stackable notifications
Mobile responsive
FiveM NUI integration (fetch callback on close)
Lightweight & clean code


KNG-Style Notifications is a lightweight, animated toast system for FiveM. To install, create a folder in resources/[standalone]/, add html/index.html, style.css, script.js, client.lua, and fxmanifest.lua, then add ensure kng-notifications to your server.cfg. The fxmanifest.lua must include ui_page 'html/index.html' and list all HTML/JS/CSS files. Use exports['kng-notifications']:ShowNotification({type='success', title='Done', message='It worked!', duration=4000}) from any client script to display a notification. Notifications auto-dismiss with a progress bar, support success, error, warning, and info types, and can be closed early with ESC. 
