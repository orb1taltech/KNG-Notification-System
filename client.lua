local notifications = {}
local notificationId = 0

– Initialize NUI
Citizen.CreateThread(function()
SetNuiFocus(false, false)
end)

– Export function for other resources to use
function ShowNotification(type, title, message, duration)
duration = duration or 5000

```
local data = {
    type = type or 'info',
    title = title or 'Notification',
    message = message or '',
    duration = duration,
    id = notificationId
}

notificationId = notificationId + 1

SendNUIMessage({
    action = 'showNotification',
    data = data
})
```

end

– Export the function
exports(‘ShowNotification’, ShowNotification)

– Register NUI callback for when notification is closed
RegisterNUICallback(‘notificationClosed’, function(data, cb)
cb(‘ok’)
end)

– Event handlers for server-triggered notifications
RegisterNetEvent(‘kng-notify:client:ShowNotification’)
AddEventHandler(‘kng-notify:client:ShowNotification’, function(type, title, message, duration)
ShowNotification(type, title, message, duration)
end)

– Command for testing (remove in production)
RegisterCommand(‘testnotify’, function(source, args, rawCommand)
local type = args[1] or ‘info’
local title = args[2] or ‘Test’
local message = table.concat(args, ’ ’, 3) or ‘This is a test notification’

```
ShowNotification(type, title, message, 5000)
```

end, false)
