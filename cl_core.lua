-- OnResourceStart
local Debug = DebugMode or false
local SafeCallEvent = TriggerServerEvent
local init = false
local wl = {}
AddEventHandler("onResourceStart", function(resourceName)
    if GetCurrentResourceName() == resourceName then
        SafeCallEvent("fs-guard:it", GlobalState["fs-guard"])
        SafeCallEvent("fs-guard:server:wl")
        init = true
    end
end)

RegisterNetEvent('fs-guard:client:wl', function(data)
    wl = data
end)

function whitelist(name)
    if #wl > 0 then
        return wl[name] or false
    end
end exports('whitelist', whitelist)

CreateThread(function()
    while not init do
        Wait(10000)
        SafeCallEvent("fs-guard:it", GlobalState["fs-guard"])
        SafeCallEvent("fs-guard:server:wl")
        init = true
    end
end)