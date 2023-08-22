GuardServerEvent = TriggerServerEvent
ATriggerServerEvent = TriggerServerEvent
local Debug = DebugMode or false
TriggerServerEvent = function(eventName, ...)
    if string.find(eventName, "__ox_cb") then
        return ATriggerServerEvent(eventName, ...)
    else
        Wait(2500)
        return GuardServerEvent(eventName, LocalPlayer.state[GlobalState["fs-guard"]], ...)
    end
end



