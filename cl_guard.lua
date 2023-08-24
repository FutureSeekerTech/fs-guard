GuardServerEvent = TriggerServerEvent
ATriggerServerEvent = TriggerServerEvent
local Debug = DebugMode or false
TriggerServerEvent = function(eventName, ...)
    if string.find(eventName, "__ox_cb") then
        return ATriggerServerEvent(eventName, ...)
    else
        Wait(1000)
        if Debug then
            print("CallEvent->"..eventName)
        end
        local ct = LocalPlayer.state[GlobalState["fs-guard"]] or 0
        local nt = ct + GlobalState["guard-updater"]
        LocalPlayer.state:set(GlobalState["fs-guard"], nt, false)
        return GuardServerEvent(eventName, ct, ...)
    end
end



