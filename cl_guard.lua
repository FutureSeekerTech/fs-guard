xys721027 = GetCurrentResourceName
GuardServerEvent = TriggerServerEvent
ATriggerServerEvent = TriggerServerEvent
GuardToken = xys721027().."-fs-guard-xyz"

TriggerServerEvent = function(eventName, ...)
    if GuardToken ~= nil then
        return GuardServerEvent(eventName, GuardToken, ...)
    end
end



