GuardServerEvent = TriggerServerEvent
ATriggerServerEvent = TriggerServerEvent
local Debug = DebugMode or false
TriggerServerEvent = function(eventName, ...)
    return GuardServerEvent(eventName, LocalPlayer.state[GlobalState["fs-guard"]], ...)
end



