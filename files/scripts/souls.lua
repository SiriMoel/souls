dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")

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

function AddSoul(type)
    local player = GetPlayer()
    local x, y = EntityGetTransform(player)
    local comp = EntityGetFirstComponentIncludingDisabled(player, "VariableStorageComponent", "soulcount_" .. type) or 0
    ComponentSetValue2(comp, "value_int", ComponentGetValue2(comp, "value_int") + 1)

    if not ModSettingGet( "tales_of_kupoli.show_souls" ) then return end
    -- spawn soul entity
    local spawnedsoul = EntityLoad("mods/tales_of_kupoli/files/entities/souls/soul_" .. type .. ".xml", x, y)
    EntityAddChild(GetPlayer(), spawnedsoul)
end

function RemoveSoul(type)
    local player = GetPlayer()
    local comp = EntityGetFirstComponentIncludingDisabled(player, "VariableStorageComponent", "soulcount_" .. type) or 0
    ComponentSetValue2(comp, "value_int", ComponentGetValue2(comp, "value_int") - 1)

    if not ModSettingGet( "tales_of_kupoli.show_souls" ) then return end
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

function GetRandomSoul()
    local player = GetPlayer()
    local whichtype = ""
    local whichtypes = {}

    for i,v in ipairs(soul_types) do
        if GetSoulsCount(v) > 0 then
            table.insert(whichtypes, v)
        end
    end

    if #whichtypes > 0 then
        whichtype = whichtypes[math.random(1, #whichtypes)]
    end

    return whichtype
end

function AddSouls(amount, includegilded)
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
        AddSoul(type)
    end
end

function RemoveSouls(amount)
    local player = GetPlayer()
    for i=1,amount do
        RemoveSoul(GetRandomSoul())
    end
end

function RenderSouls()
    local player = GetPlayer()
    local x, y = EntityGetTransform(player)
    local allsoulentities = EntityGetWithTag("talesofkupoli_soul")
    for i,v in ipairs(allsoulentities) do
        EntityKill(v)
    end
    if ModSettingGet( "tales_of_kupoli.show_souls" ) then
        for i,v in ipairs(soul_types) do
            local soulcomp = EntityGetFirstComponentIncludingDisabled(player, "VariableStorageComponent", "soulcount_" .. v) or 0
            local scount = ComponentGetValue2(soulcomp, "value_int")
            for i=1,scount do
                EntityLoad("mods/tales_of_kupoli/files/entities/souls/soul_" .. v .. ".xml", x, y)
            end
        end
    else
        return
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