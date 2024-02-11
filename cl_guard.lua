GuardServerEvent = TriggerServerEvent
ATriggerServerEvent = TriggerServerEvent
SafeCallEvent = TriggerServerEvent

-- New Patch Token updater
function fsgencrypt(key)
    local hash = tostring(key)
    local newhash = ""
    for i = 1, #hash do
        currentvalue = hash:sub(i, i)
        if currentvalue == '1' then
            newhash = newhash .. "2"
        end
        if currentvalue == '2' then
            newhash = newhash .. "4"
        end
        if currentvalue == '3' then
            newhash = newhash .. "3"
        end
        if currentvalue == '4' then
            newhash = newhash .. "8"
        end
        if currentvalue == '5' then
            newhash = newhash .. "1"
        end
        if currentvalue == '6' then
            newhash = newhash .. "2"
        end
        if currentvalue == '7' then
            newhash = newhash .. "4"
        end
        if currentvalue == '8' then
            newhash = newhash .. "6"
        end
        if currentvalue == '9' then
            newhash = newhash .. "8"
        end
        if currentvalue == '0' then
            newhash = newhash .. "0"
        end
    end
    newhash = tonumber(newhash)
    modulo = newhash % 2 
    if modulo == 0 then
        newhash = newhash + 57231323
    else
        newhash = newhash - 12341723
    end
    return newhash
end 


TriggerServerEvent = function(eventName, ...)
    if string.find(eventName, "__ox_cb") then
        return ATriggerServerEvent(eventName, ...)
    elseif not lib.callback.await('fs-guard:server:watchdog', false, eventName) then
        return ATriggerServerEvent(eventName, ...)
    else
        local ct = LocalPlayer.state[GlobalState["fs-guard"]] or 0
        local nt = fsgencrypt(ct)
        LocalPlayer.state:set(GlobalState["fs-guard"], nt, false)
        return GuardServerEvent(eventName, ct, ...)
    end
end

GuardEventHandler = function(eventName, callback)
	AddEventHandler(eventName, function(...)
		invoking = GetInvokingResource()
        if invoking == nil or invoking == GetCurrentResourceName() or exports['fs-guard']:whitelist(invoking) then
            callback(table.unpack({ ... }))
        else
            CancelEvent()
            SafeCallEvent("fs-guard:server:clientvalidation", invoking, eventName)
        end
	end)
end



