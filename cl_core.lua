-- OnResourceStart
local Debug = DebugMode or false
local SafeCallEvent = TriggerServerEvent
local init = false

AddEventHandler("onResourceStart", function(resourceName)
    if GetCurrentResourceName() == resourceName then
        if Debug then
            print("hash : "..GlobalState["fs-guard"])
            print("fs-guard calling init token")
        end
        SafeCallEvent("fs-guard:it", GlobalState["fs-guard"])
        init = true
    end
end)

CreateThread(function()
    while not init do
        Wait(10000)
        if Debug then
            print("hash : "..GlobalState["fs-guard"])
            print("fs-guard calling init token")
        end
        SafeCallEvent("fs-guard:it", GlobalState["fs-guard"])
        init = true
    end
end)