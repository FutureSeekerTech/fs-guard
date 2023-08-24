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
        tu(src)
        return false
    end
end exports("tc", tc)

-- Token Init
function ti(src)
    Player(src).state:set(GlobalState["fs-guard"], tg(), true)
    if debug then
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

-- OnResourceStart
AddEventHandler("onResourceStart", function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
        print("FS-GUARD V2 by FutureSeekerTech Started")
        GlobalState["fs-guard"] = hg()
        GlobalState["guard-updater"] = hg2()
        print("FS-GUARD V2 Hash Key: "..GlobalState["fs-guard"])
        print("FS-GUARD V2 Updater Key: "..GlobalState["guard-updater"])
    end
end)
