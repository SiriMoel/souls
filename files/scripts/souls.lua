dofile_once("mods/souls/files/scripts/utils.lua")

soul_types = {
    "bat",
    "fly",
    "friendly",
    "gilded",
    "mage",
    "orcs",
    "slimes",
    "spider",
    "zombie",
    "worm",
    "fungus",
    "ghost",
    "boss",
}

if ModIsEnabled("Apotheosis") then
    soul_types = {
        "bat",
        "fly",
        "friendly",
        "gilded",
        "mage",
        "orcs",
        "slimes",
        "spider",
        "zombie",
        "worm",
        "fungus",
        "ghost",
        "boss",
        "mage_corrupted",
        "ghost_whisp",
    }
end

-- Initialises the Souls mechanic, should only be ran once in init.lua
function SoulsInit()
    local player = GetPlayer()
    for i,v in ipairs(soul_types) do
        EntityAddComponent2(player, "VariableStorageComponent", {
            _tags="soulcount_" .. v,
            name="soulcount_" .. v,
            value_int=0,
        })
    end
end

-- Use this when printing the name of souls
function SoulNameCheck(string)
    if string == "mage_corrupted" then
        string = "corrupted mage"
    end
    if string == "ghost_whisp" then
        string = "whisp"
    end
    if string == "orcs" then
        string = "hiisi"
    end
    if string == "0" then
        string = "any"
    end
    return string
end

-- Adds souls, provide type and amount
function AddSouls(type, amount)
    local player = GetPlayer()
    local x, y = EntityGetTransform(player)
    local comp = EntityGetFirstComponentIncludingDisabled(player, "VariableStorageComponent", "soulcount_" .. type) or 0
    ComponentSetValue2(comp, "value_int", ComponentGetValue2(comp, "value_int") + amount)
    if amount == 1 then
        if ModSettingGet( "souls.say_acquired_soul" ) then
            GamePrint( "You have acquired a " .. SoulNameCheck(soul) .. " soul." )
        end
    else
        if ModSettingGet( "souls.say_acquired_soul" ) then
            GamePrint( "You have acquired " .. amount .. " " .. SoulNameCheck(soul) .. " souls." )
        end
    end
end

-- Removes a single soul
function RemoveSoul(type)
    local player = GetPlayer()
    local comp = EntityGetFirstComponentIncludingDisabled(player, "VariableStorageComponent", "soulcount_" .. type) or 0
    ComponentSetValue2(comp, "value_int", ComponentGetValue2(comp, "value_int") - 1)
end

-- Gets the amount of souls of a specific type, or "all" for all souls
---@return number
function GetSoulsCount(type)
    local player = GetPlayer()
    local count = 0
    if type == "all" then
        for i,v in ipairs(soul_types) do
            count = count + (ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(player, "VariableStorageComponent", "soulcount_" .. v) or 0, "value_int") or 0)
        end
    else
        count = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(player, "VariableStorageComponent", "soulcount_" .. type) or 0, "value_int")
    end
    return count
end

-- Gets a random soul
function GetRandomSoul(includeboss)
    local player = GetPlayer()
    local whichtype = ""
    local whichtypes = {}
    for i,v in ipairs(soul_types) do
        if GetSoulsCount(v) > 0 then
            if includeboss == false then
                if whichtype == "boss" then
                    
                else
                    table.insert(whichtypes, v)
                end
            else
                table.insert(whichtypes, v)
            end
        end
    end
    if #whichtypes > 0 then
        whichtype = whichtypes[math.random(1, #whichtypes)]
    end
    return whichtype
end

-- GetRandomSoul() but for wands, used incase the wand is meant to only consume a specific soul type
function GetRandomSoulForWand(wand)
    local which_soul = "0"
    local comp_whichsoul = EntityGetFirstComponentIncludingDisabled(wand, "VariableStorageComponent", "which_soul_type")
    if comp_whichsoul == nil then
        comp_whichsoul = EntityAddComponent2(wand, "VariableStorageComponent", {
            _tags="which_soul_type",
            name="which_soul_type",
            value_string="0",
        })
    end
    local comp_whichsoulnumber = EntityGetFirstComponentIncludingDisabled(wand, "VariableStorageComponent", "which_soul_type_number")
    if comp_whichsoulnumber == nil then
        comp_whichsoulnumber = EntityAddComponent2(wand, "VariableStorageComponent", {
            _tags="which_soul_type_number",
            name="which_soul_type_number",
            value_int="1",
        })
    end
    local comp_whichsoul = EntityGetFirstComponentIncludingDisabled(wand, "VariableStorageComponent", "which_soul_type") or 0
    local whichsoul = ComponentGetValue2(comp_whichsoul, "value_string")
    which_soul = whichsoul
    if which_soul == "0" then
        if GetSoulsCount("all") > 0 then
            which_soul = GetRandomSoul(false)
        else
            return "0"
        end
    end
    if GetSoulsCount(which_soul) > 0 then
        return which_soul
    else
        return "0"
    end
end

-- Does the provided wand use a specific soul type or can it use any soul?
function DoesWandUseSpecificSoul(wand)
    local which_soul = "0"
    local comp_whichsoul = EntityGetFirstComponentIncludingDisabled(wand, "VariableStorageComponent", "which_soul_type") or 0
    local whichsoul = ComponentGetValue2(comp_whichsoul, "value_string")
    which_soul = whichsoul
    if which_soul == "0" then
        return false
    else
        return true
    end
end

-- What soul type does the wand use? Returns "0" if the wand does not consume a specific soul type
function GetWandSoulType(wand)
    local which_soul = "0"
    local comp_whichsoul = EntityGetFirstComponentIncludingDisabled(wand, "VariableStorageComponent", "which_soul_type") or 0
    local whichsoul = ComponentGetValue2(comp_whichsoul, "value_string")
    which_soul = whichsoul
    return which_soul
end

-- Gets a random soul type
function GetRandomSoulType(includeboss)
    local type = soul_types[math.random(1, #soul_types)]
    if includeboss then
        return type
    else
        if type == "boss" then
            type = "orcs"
        end
        return type
    end
end

-- Adds random souls
function AddRandomSouls(amount, includegilded)
    for i=1,amount do
        local type = ""
        if includegilded then
            type = soul_types[math.random(1,soultypes)]
        else
            type = soul_types[math.random(1,soultypes)]
            if type == "gilded" then
                type = "orcs"
            end
        end
        AddSouls(type, 1)
    end
end

-- Removes random souls, does not include boss souls
function RemoveRandomSouls(amount)
    for i=1,amount do
        RemoveSoul(GetRandomSoul(false))
    end
end

-- Tales' reap.lua but a function
function ReapSoul(entity, amount, random)
    if #EntityGetInRadiusWithTag(x, y, 500, "player_unit") < 1 then return end
    local herd_id_number = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( entity, "GenomeDataComponent" ) or 0, "herd_id")
    local herd_id = HerdIdToString(herd_id_number)
    local herd_id_old = herd_id
    local x, y = EntityGetTransform(entity)
    local player = GetPlayer()
    local ok = false
    local boss = false
    local boss_names = {
        "$animal_maggot_tiny",
        "$animal_fish_giga",
        "$animal_boss_alchemist",
        "$animal_boss_centipede",
        "$animal_boss_ghost",
        "$animal_boss_limbs",
        "$animal_boss_meat",
        "$animal_boss_pit",
        "$animal_boss_robot",
        "$animal_islandspirit",
        "$animal_boss_wizard",
    }
    for i,v in ipairs(boss_names) do
        if EntityGetName(entity) == GameTextGetTranslatedOrNot(v) then
            ok = true
            boss = true
        end
    end
    if EntityHasTag(entity, "boss") then
        boss = true
    end
    if table.contains(soul_types, herd_id) then
        ok = true
    end
    if table.contains(boss_names, EntityGetName(entity)) then
        ok = true
    end
    if ok then
        SetRandomSeed(x, y)
        math.randomseed(x, y+GameGetFrameNum())
        if math.random(1,15) == 10 then
            herd_id = "gilded"
        end
        if random == true then
            herd_id = GetRandomSoulType(false)
            if herd_id == "gilded" then
                if math.random(1,15) == 10 then
                    herd_id = "gilded"
                else
                    herd_id = herd_id_old
                end
            end
        end
        if boss == true then
            herd_id = "boss"
        end
        if ModSettingGet("souls.say_soul") == true then
            if amount == 1 then
                GamePrint("You have acquired a " .. SoulNameCheck(herd_id) .. " soul!")
            else
                GamePrint("You have acquired " .. amount .. " " .. SoulNameCheck(herd_id) .. " souls!")
            end
        end
        if EntityHasTag(player, "souls_anima_conduit") then
            local comp_damagemodel = EntityGetFirstComponentIncludingDisabled(player, "DamageModelComponent")
            if comp_damagemodel ~= nil then
                local hp = ComponentGetValue2(comp_damagemodel, "hp")
                local max_hp = ComponentGetValue2(comp_damagemodel, "max_hp")
                -- heals 0.5% rounding up, stronger at lower max hp, weaker at higher max hp as you get more reaping spells
                hp = hp + math.ceil((max_hp * 0.005))
                if hp > max_hp then
                    hp = max_hp
                end
                ComponentSetValue2(comp_damagemodel, "hp", hp)
            end
        end
        AddSouls(herd_id, amount)
    end
end