local discordWebHook = ""
local Debug = DebugMode or false
-- random word hash generator
function hg()
    local a = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
    local b = ""
    for i = 1, 6 do
        b = b .. string.char(string.byte(a, math.random(1, #a)))
    end
    return b
end

-- random number hash generator for updater
function hg2()
    local a = math.random(1, 999999)
    return a
end

-- token generator
function tg()
    local a = math.random(1000000000000000, 9999999999999999)
    return a
end

-- token checker (Dont Change)
function tc(src, token)
    -- var token server
    local ts = Player(src).state[GlobalState["fs-guard"]]
    -- var token client
    local tc = token
    -- check token
    if ts == tc then
        -- update token even token is correct
        if Debug then
            print("token checker for client "..src.." is correct")
            print("token server: "..ts)
            print("token client: "..tc)
        end
        tu(src)
        return true
    else
        -- Update token
        if Debug then
            print("token checker for client "..src.." is wrong")
            print("token server: "..tostring(ts))
            print("token client: "..tostring(tc))
        end
        return false
    end
end exports("tc", tc)

-- Token Init
function ti(src)
    Player(src).state:set(GlobalState["fs-guard"], tg(), true)
    if Debug then
        print("token init->id "..src.."->"..Player(src).state[GlobalState["fs-guard"]])
    end
end

-- Update Token
function tu(src)
    -- current token
    local ct = Player(src).state[GlobalState["fs-guard"]]
    -- new token
    local nt = ct + GlobalState["guard-updater"]
    Player(src).state:set(GlobalState["fs-guard"], nt, false)
    if Debug then
        print("tu->"..src.."->"..Player(src).state[GlobalState["fs-guard"]])
    end
end

RegisterNetEvent("fs-guard:it", function(hash)
    -- server hash
    local sh = GlobalState["fs-guard"]
    -- client hash
    local ch = hash
    -- check hash
    if sh == ch then
        -- update token
        if Debug then
            print("Server Hash: "..sh)
            print("Client Hash: "..ch)
            print("fs-guard:it: ".."Hash Matched")
        end
        ti(source)
    else
        if Debug then
            print("Server Hash: "..sh)
            print("Client Hash: "..ch)
            print("fs-guard:it: ".."Hash Not Matched")
        end
        -- kick player
        -- DropPlayer(source, "FS-GUARD V2 by FutureSeekerTech")
    end
end)

-- Load Ban Data
function GuardGetBanData()
    ListBan = {}
    lastBanId = 0
    MySQL.query('SELECT * FROM fsguard', {}, function(result)
        if result[1] then
            for i = 1, #result, 1 do
                table.insert(ListBan, {
                    banid              = result[i].id,
                    name              = result[i].name,
                    license              = result[i].license,
                    steam              = result[i].steam,
                    hwid              = result[i].hwid,
                    discord              = result[i].discord,
                    ip              = result[i].ip,
                })
                lastBanId = tonumber(result[i].id)
            end
        end
    end)
end

function GuardNotify(name, ip, steam, hwid, license, discord, eventName)
    lastBanId = lastBanId+1
	local msg = {["color"] = "10552316", ["type"] = "rich", ["title"] = "Unauthorized Event Triggered", ["description"] =  "**Name : **" ..name .. "\n **Reason : **" .."[FS-Guard] This player trigger unauthorized event".. "\n **Event : **||" ..eventName.. "||\n **IP : **||" ..ip.. "||\n **Steam : **||" .. steam .. "||\n **HWID: **||" ..hwid.. "||\n **Rockstar License : **||" .. license .. "||\n **Discord : **<@" .. discord .. ">".."||\n **Ban ID : **"..tostring(lastBanId), ["footer"] = { ["text"] = " © FS Guard V2 | "..os.date("%c").."" }}
	if name ~= "Unknown" then
	  PerformHttpRequest(discordWebHook, function(err, text, headers) end, "POST", json.encode({username = "FS Guard V2", embeds = {msg}, avatar_url = "https://cdn.discordapp.com/attachments/1078837522882367508/1114897951177855059/fstech_logo.png"}), {["Content-Type"] = "application/json"})
	end
end exports("GuardNotify", GuardNotify)

function ExploitBan(id, license, steam, hwid, discord, ip, reason)
	MySQL.insert('INSERT INTO fsguard (id, name, license, steam, hwid, discord, ip, reason) VALUES (?, ?, ?, ?, ?, ?, ?, ?)', {
        lastBanId,
		GetPlayerName(id),
		license, 
		steam, 
		hwid, 
		discord, 
		ip, 
		reason
	})
	DropPlayer(id, 'You were permanently banned by the server for: Exploiting')
	GuardGetBanData()
end exports("ExploitBan", ExploitBan)

-- Get Player Data
function GuardGetPlayerData(source)
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
        playerip = '-'
        end
    end
    if playerdiscord == nil then
        playerdiscord = '-'
    end
    if steam == nil then
        steam = '-'
    end
    if hwid == nil then
        hwid = '-'
    end
    local data = {}
    data.name = name or '-'
    data.license = license or '-'
    data.steam = steam or '-'
    data.discord = playerdiscord or '-'
    data.hwid = hwid or '-'
    data.ip = playerip or '-'
    return data
end exports('GuardGetPlayerData', GuardGetPlayerData)

-- Ban Player
function GuardBanPlayer(source, eventName)
    local data = GuardGetPlayerData(source)
	GuardNotify(data.name, data.ip, data.steam, data.hwid, data.license, data.discord, eventName)
	ExploitBan(source, data.license, data.steam, data.hwid, data.discord, data.ip, "Exploiting "..eventName)
end exports("GuardBanPlayer", GuardBanPlayer)

-- Player Checker
AddEventHandler('playerConnecting', function (playerName,setKickReason)
    local data = GuardGetPlayerData(source)
    for i = 1, #ListBan, 1 do
        -- Rockstar License Checker
        if not((tostring(ListBan[i].license)) == "-" ) and (tostring(ListBan[i].license)) == tostring(data.license) then
            setKickReason('You are banned by the server for exploiting. Your ban id: '..ListBan[i].banid)
            CancelEvent()
        end
        -- Steam Checker
        if not((tostring(ListBan[i].steam)) == "-" ) and (tostring(ListBan[i].steam)) == tostring(data.steam) then
            setKickReason('You are banned by the server for exploiting. Your ban id: '..ListBan[i].banid)
            CancelEvent()
        end
        -- HWID Checker
        if not((tostring(ListBan[i].hwid)) == "-" ) and (tostring(ListBan[i].hwid)) == tostring(data.hwid) then
            setKickReason('You are banned by the server for exploiting. Your ban id: '..ListBan[i].banid)
            CancelEvent()
        end
        -- IP Checker Bypassed
        -- if not((tostring(ListBan[i].ip)) == "-" ) and (tostring(ListBan[i].ip)) == tostring(data.ip) then
        --     setKickReason('You are banned by the server for exploiting. Your ban id: '..ListBan[i].banid)
        --     CancelEvent()
        -- end
        -- Discord Checker
        if not((tostring(ListBan[i].discord)) == "-" ) and (tostring(ListBan[i].discord)) == tostring(data.discord) then
            setKickReason('You are banned by the server for exploiting. Your ban id: '..ListBan[i].banid)
            CancelEvent()
        end
    end
end)

RegisterCommand("fsguard", function(source, args, rawCommand)
    if args[1] == nil then 
      print("Gunakan fsguard unban <banid>")
    end
    -- If the source is > 0, then that means it must be a player.
    if (source > 0) then
      return false
    -- If it's not a player, then it must be RCON, a resource, or the server console directly.
    else
      if args[1] == "unban" then
        if args[2] == nil then
            print("Gunakan fsguard unban <banid>")
        else
            MySQL.query('DELETE from fsguard WHERE id = ?', {
                tonumber(args[2]),
            })
            print("Unban command executed")
            GuardGetBanData()
        end
      end
    end
  end, true)

-- OnResourceStart
AddEventHandler("onResourceStart", function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
        print("FS-GUARD V2 by FutureSeekerTech Started")
        GlobalState["fs-guard"] = hg()
        GlobalState["guard-updater"] = hg2()
        print("FS-GUARD V2 Hash Key: "..GlobalState["fs-guard"])
        print("FS-GUARD V2 Updater Key: "..GlobalState["guard-updater"])
        GuardGetBanData()
    end
end)

