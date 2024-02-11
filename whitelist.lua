local resources = {}

function GetAllResources()
    for resIdx = 0, GetNumResources() - 1 do
        local resource = GetResourceByFindIndex(resIdx)
        resources[resource] = true
    end
end
GetAllResources()

RegisterNetEvent('fs-guard:server:wl', function()
    print("fs-guard:server:wl")
    _source = source
    TriggerClientEvent("fs-guard:client:wl", _source, resources)
end)

AddEventHandler('onResourceStart', function(resource)
    if resources[resource] == nil or resources[resource] == false then
        GetAllResources()
        TriggerClientEvent("fs-guard:client:wl", -1, resources)
    end
end)

AddEventHandler('onResourceStop', function(resource)
    resources[resource] = nil
    TriggerClientEvent("fs-guard:client:wl", -1, resources)
end)

RegisterCommand("rcperm", function(source, args, rawCommand)
    if args[1] == nil or args[1] == "" then 
      print("Gunakan rcperm <resourcename>")
    end
    -- If the source is > 0, then that means it must be a player.
    if (source > 0) then
      return false
    -- If it's not a player, then it must be RCON, a resource, or the server console directly.
    else
        print("permission resource:" .. args[1].." : "..tostring(resources[args[1]]))
    end
end, true)


