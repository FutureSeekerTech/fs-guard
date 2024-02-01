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
    end
end)

AddEventHandler('onResourceStop', function(resource)
    resources[resource] = nil
end)

