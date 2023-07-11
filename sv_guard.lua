GuardToken = GetCurrentResourceName().."-fs-guard-xyz"
local discordWebHook = "" --Discord webhook untuk notifikasi player banned
SafeEventHandler = AddEventHandler
-- Token Check Event Handler
-- @@ Check token when player trigger server event
local QBCore = exports['qb-core']:GetCoreObject()
GuardEventHandler = function(eventName, callback)
	AddEventHandler(eventName, function(token, ...)
		local player = source
		local playerName = GetPlayerName(player)

		if GuardToken ~= token and GuardToken ~= "futureseekerbypass" then
			local license = nil
			local playerip      = nil
			local playerdiscord = nil
			local hwid        = GetPlayerToken(source, 0)
			local steam       = nil
			local name  = GetPlayerName(source)

			for k,v in pairs(GetPlayerIdentifiers(source))do   
				if string.sub(v, 1, string.len("license:")) == "license:" then
				license = v
				elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
				steam  = v
				elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
				playerip = v
				elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
				playerdiscord = v
				end
			end
			
			if playerip == nil then
				playerip = GetPlayerEndpoint(source)
				if playerip == nil then
				playerip = 'Not found'
				end
			end
			if playerdiscord == nil then
				playerdiscord = 'Not found'
			end
			if steam == nil then
				steam = 'Not found'
			end
			if hwid == nil then
				hwid = 'Not found'
			end
			
			discordNotify(name, playerip, steam, hwid, license, playerdiscord, eventName)
            ExploitBan(source, "Exploiting "..eventName)
			CancelEvent()
			return
		end
		callback(table.unpack({ ... }))
	end)
end

function discordNotify(name, ip, steam, hwid, license, discord, eventName)
	local msg = {["color"] = "10552316", ["type"] = "rich", ["title"] = "Unauthorized Event Triggered", ["description"] =  "**Name : **" ..name .. "\n **Reason : **" .."[FutureSeeker AC] This player trigger unauthorized event".. "\n **Event : **||" ..eventName.. "||\n **IP : **||" ..ip.. "||\n **Steam : **||" .. steam .. "||\n **HWID: **||" ..hwid.. "||\n **Rockstar License : **||" .. license .. "||\n **Discord : **<@" .. discord .. ">", ["footer"] = { ["text"] = " © FutureSeeker AC | "..os.date("%c").."" }}
	  
	if name ~= "Unknown" then
	  PerformHttpRequest(discordWebHook, function(err, text, headers) end, "POST", json.encode({username = "FutureSeeker AC", embeds = {msg}, avatar_url = "https://cdn.discordapp.com/attachments/1078837522882367508/1114897951177855059/fstech_logo.png"}), {["Content-Type"] = "application/json"})
	end
end

function ExploitBan(id, reason)
	MySQL.insert('INSERT INTO bans (name, license, discord, ip, reason, expire, bannedby) VALUES (?, ?, ?, ?, ?, ?, ?)', {
		GetPlayerName(id),
		QBCore.Functions.GetIdentifier(id, 'license'),
		QBCore.Functions.GetIdentifier(id, 'discord'),
		QBCore.Functions.GetIdentifier(id, 'ip'),
		reason,
		2147483647,
		'fs-guard'
	})
	TriggerEvent('qb-log:server:CreateLog', 'bans', 'Player Banned', 'red', string.format('%s was banned by %s for %s', GetPlayerName(id), 'fs-guard', reason), true)
	DropPlayer(id, 'You were permanently banned by the server for: Exploiting')
end




