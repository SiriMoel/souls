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

function AddSouls(type, amount)
    local player = GetPlayer()
    local x, y = EntityGetTransform(player)
    local comp = EntityGetFirstComponentIncludingDisabled(player, "VariableStorageComponent", "soulcount_" .. type) or 0
    ComponentSetValue2(comp, "value_int", ComponentGetValue2(comp, "value_int") + amount)
end

function RemoveSoul(type)
    local player = GetPlayer()
    local comp = EntityGetFirstComponentIncludingDisabled(player, "VariableStorageComponent", "soulcount_" .. type) or 0
    ComponentSetValue2(comp, "value_int", ComponentGetValue2(comp, "value_int") - 1)

    if not ModSettingGet( "souls.show_souls" ) then return end
    -- kill soul entity
    EntityKill(EntityGetWithTag("soul_" .. type)[1])
end

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

function GetRandomSoulForWand(wand)
    local comp_whichsoul = EntityGetFirstComponentIncludingDisabled(wand, "VariableStorageComponent", "which_soul_type") or 0
    local whichsoul = ComponentGetValue2(comp_whichsoul, "value_string")
    if whichsoul == "0" then
        return GetRandomSoul(false)
    end
end

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

function RemoveRandomSouls(amount)
    for i=1,amount do
        RemoveSoul(GetRandomSoul())
    end
end

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
    return string
end

function ReapSoul(entity_id, amount, random)
    local herd_id_number = ComponentGetValue2( EntityGetFirstComponent( entity, "GenomeDataComponent" ) or 0, "herd_id")
    local herd_id = HerdIdToString(herd_id_number)
    local x, y = EntityGetTransform(entity)
    local ok = false
    if #EntityGetInRadiusWithTag(x, y, 300, "player_unit") < 1 then return end
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
        if table.contains(boss_names, EntityGetName(entity_id)) then
            herd_id = "boss"
        end
        if ModSettingGet("souls.say_soul") == true then
            GamePrint("You have acquired a " .. SoulNameCheck(herd_id) .. " soul!")
        end
        AddSouls(herd_id, amount)
    end
end