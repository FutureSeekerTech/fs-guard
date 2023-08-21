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

-- token generator
function tg()
    local a = math.random(1, 999).."-"..math.random(1, 999).."-"..math.random(1, 999).."-"..math.random(1, 999)
    return a
end

-- token checker
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
            print("token server: "..ts)
            print("token client: "..tc)
        end
        tu(src)
        return false
    end
end exports("tc", tc)

-- Update Token
function tu(src)
    Player(src).state:set(GlobalState["fs-guard"], tg(), true)
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
            print("fs-guard:it: ".."Hash Matched")
        end
        tu(source)
    else
        if Debug then
            print("fs-guard:it: ".."Hash Not Matched")
        end
        -- kick player
        -- DropPlayer(source, "FS-GUARD V2 by FutureSeekerTech")
    end
end)

-- print token
RegisterCommand("ptoken", function()
    print(tg())
end, false)

RegisterCommand("phash", function()
    print(hg())
end, false)

-- OnResourceStart
AddEventHandler("onResourceStart", function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
        print("FS-GUARD V2 by FutureSeekerTech Started")
        GlobalState["fs-guard"] = hg()
        print("FS-GUARD V2 Hash Key: "..GlobalState["fs-guard"])
    end
end)
