dofile_once("mods/moles_n_more/files/scripts/utils.lua")

soul_types = {
    "bat",
    "fly",
    "friendly",
    "gilded",
    "mage",
    "orcs",
    "slimes",
    "spider",
    "synthetic",
    "zombie",
    "worm",
    "fungi",
}

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

    if not ModSettingGet( "moles_n_more.show_souls" ) then return end
    -- spawn soul entity
    EntityLoad("mods/moles_n_more/files/entities/souls/soul_" .. type .. ".xml", x, y)
end

function RemoveSoul(type)
    local player = GetPlayer()
    local comp = EntityGetFirstComponentIncludingDisabled(player, "VariableStorageComponent", "soulcount_" .. type) or 0
    ComponentSetValue2(comp, "value_int", ComponentGetValue2(comp, "value_int") - 1)

    if not ModSettingGet( "moles_n_more.show_souls" ) then return end
    -- kill soul entity
    EntityKill(EntityGetWithTag("soul_" .. type)[1])
end

function GetRandomSoul() 
    local player = GetPlayer()
    local whichtype = soul_types[math.random(1, #soul_types)]
    while ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(player, "VariableStorageComponent", "soulcount_" .. whichtype) or 0, "value_int") <= 0 do
        whichtype = soul_types[math.random(1, #soul_types)] 
    end
    return whichtype
end

function GetSoulsCount(type)
    local player = GetPlayer()
    local count = 0
    if type == "all" then
        for i,v in ipairs(soul_types) do
            count = count + ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(player, "VariableStorageComponent", "soulcount_" .. v) or 0, "value_int")
        end
    else
        count = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(player, "VariableStorageComponent", "soulcount_" .. type) or 0, "value_int")
    end
    return count
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
    local allsoulentities = EntityGetWithTag("mnm_soul")
    for i,v in ipairs(allsoulentities) do
        EntityKill(v)
    end
    if ModSettingGet( "moles_n_more.show_souls" ) then 
        for i,v in ipairs(soul_types) do
            local soulcomp = EntityGetFirstComponentIncludingDisabled(player, "VariableStorageComponent", "soulcount_" .. v) or 0
            local scount = ComponentGetValue2(soulcomp, "value_int")
            for i=1,scount do
                EntityLoad("mods/moles_n_more/files/entities/souls/soul_" .. v .. ".xml", x, y)
            end
        end
    else
        return
    end
end