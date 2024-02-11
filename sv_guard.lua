SafeEventHandler = AddEventHandler
-- Token Check Event Handler
-- @@ Check token when player trigger server event
GuardEventHandler = function(eventName, callback)
	AddEventHandler('onResourceStart', function(resource)
		if resource == "fs-guard" or resource == GetCurrentResourceName() then
			CreateThread(function()
				while GetResourceState("fs-guard") ~= "started" do
					Wait(0)
				end
				exports['fs-guard']:EventRegister(eventName)
			end)
		end
	end)
	AddEventHandler(eventName, function(token, ...)
		local player = source
		local playerName = GetPlayerName(player)
		local checkToken = exports['fs-guard']:tc(player, token)
		if not checkToken then
			exports['fs-guard']:GuardBanPlayer(source, eventName)
			CancelEvent()
			return
		end
		callback(table.unpack({ ... }))
	end)
end




