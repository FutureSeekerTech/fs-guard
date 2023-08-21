DebugEventHandler = function(eventName, callback)
	AddEventHandler(eventName, function(token, ...)
		local player = source
		local checkToken = exports['fs-guard']:tc(player, token)
		if not checkToken then
			print("Unauthorized Event Triggered: "..eventName.."")
			return
		end
		callback(table.unpack({ ... }))
	end)
end

RegisterNetEvent("fs-guard:test")
DebugEventHandler("fs-guard:test", function()
    print("fs-guard:test")
end)