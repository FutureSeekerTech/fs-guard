GuardServerEvent = TriggerServerEvent
ATriggerServerEvent = TriggerServerEvent
local Debug = DebugMode or false
TriggerServerEvent = function(eventName, ...)
    Wait(1000)
    if string.find(eventName, "__ox_cb") then
        return ATriggerServerEvent(eventName, ...)
    else
        return GuardServerEvent(eventName, LocalPlayer.state[GlobalState["fs-guard"]], ...)
    end
end



