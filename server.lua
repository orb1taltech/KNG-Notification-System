– Function to send notification to specific player
function NotifyPlayer(playerId, type, title, message, duration)
TriggerClientEvent(‘kng-notify:client:ShowNotification’, playerId, type, title, message, duration)
end

– Function to send notification to all players
function NotifyAll(type, title, message, duration)
TriggerClientEvent(‘kng-notify:client:ShowNotification’, -1, type, title, message, duration)
end

– Export functions for other resources
exports(‘NotifyPlayer’, NotifyPlayer)
exports(‘NotifyAll’, NotifyAll)

– Register server events
RegisterServerEvent(‘kng-notify:server:NotifyPlayer’)
AddEventHandler(‘kng-notify:server:NotifyPlayer’, function(targetId, type, title, message, duration)
local source = source
– Add permission checks here if needed
NotifyPlayer(targetId, type, title, message, duration)
end)

– Example usage command (admin only - add your permission system)
RegisterCommand(‘notify’, function(source, args, rawCommand)
if source == 0 then – Console
if #args >= 4 then
local targetId = tonumber(args[1])
local type = args[2]
local title = args[3]
local message = table.concat(args, ’ ’, 4)

```
        NotifyPlayer(targetId, type, title, message, 5000)
    else
        print('Usage: notify [playerid] [type] [title] [message]')
    end
end
```

end, true)
