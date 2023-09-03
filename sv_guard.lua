SafeEventHandler = AddEventHandler
-- Token Check Event Handler
-- @@ Check token when player trigger server event
GuardEventHandler = function(eventName, callback)
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




