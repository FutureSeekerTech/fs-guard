GuardServerEvent = TriggerServerEvent
ATriggerServerEvent = TriggerServerEvent
local Debug = DebugMode or false
TriggerServerEvent = function(eventName, ...)
    Wait(1000)
    return GuardServerEvent(eventName, LocalPlayer.state[GlobalState["fs-guard"]], ...)
end



