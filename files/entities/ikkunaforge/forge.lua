dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/alterants.lua")
dofile_once("data/scripts/gun/procedural/gun_action_utils.lua")

local forge = GetUpdatedEntityID()
local x, y = EntityGetTransform(forge)

local targets = EntityGetInRadiusWithTag(x, y, 20, "kupoli_alterant")

local wand = EntityGetInRadiusWithTag(x, y, 15, "wand")[1]

local comp_stored_alterants = EntityGetFirstComponentIncludingDisabled(forge, "VariableStorageComponent", "stored_alterants") or 0
local stored_alterants_string = ComponentGetValue2(comp_stored_alterants, "value_string")
local stored_alterants = {}

for i,v in ipairs(targets) do
    local comp_alterant = EntityGetFirstComponentIncludingDisabled(v, "VariableStorageComponent", "alterant_id") or 0
    local alterant_id = ComponentGetValue2(comp_alterant, "value_string")
    stored_alterants_string = stored_alterants_string .. alterant_id .. ","
    ComponentSetValue2(comp_stored_alterants, "value_string", stored_alterants_string)
    if ModSettingGet( "souls.testing" ) then
        GamePrint(stored_alterants_string)
    end
    EntityKill(v)
    GamePrint("Alterant stored!")
end

if wand ~= nil then
    local comp_applied_alterants = EntityGetFirstComponentIncludingDisabled(forge, "VariableStorageComponent", "applied_alterants") 
    or EntityAddComponent2(wand, "VariableStorageComponent", {
        _tags="applied_alterants",
        name="applied_alterants",
        value_string="",
    })
    local applied_alterants = {}
    local applied_alterants_string = ComponentGetValue2(comp_stored_alterants, "value_string")
    for i in string.gmatch(applied_alterants_string, '[^,]+') do
        table.insert(applied_alterants, i)
    end
    for i in string.gmatch(stored_alterants_string, '[^,]+') do
        table.insert(stored_alterants, i)
    end
    if #stored_alterants <= 0 then return end
    for i,v in ipairs(stored_alterants) do
        local alterant = {}
        for ii,vv in ipairs(alterants) do
            if vv.id == v then
                alterant = vv
            end
        end
        --if table.contains(applied_alterants, alterant.id) == false then
            EntityAddComponent2(wand, "SpriteComponent", {
                _enabled="1",
                _tags="enabled_in_hand,enabled_in_world",
                offset_x=4,
                offset_y=4,
                image_file=alterant.sprite_onwand,
            })
            if alterant.actionid ~= "" then
                AddGunActionPermanent(wand, alterant.actionid)
            end
            alterant.func_apply(wand)
            GamePrint( alterant.name .. " applied!")
            table.insert(applied_alterants, alterant.id)
        --else
            --GamePrint(alterant.name .. " has already been applied to that wand. Silly!")
        --end
    end
    stored_alterants = {}
    stored_alterants_string = ""
    for i,v in ipairs(stored_alterants) do
        stored_alterants_string = stored_alterants_string .. "," .. v
    end
    applied_alterants_string = ""
    for i,v in ipairs(applied_alterants) do
        applied_alterants_string = applied_alterants_string .. "," .. v
    end
    if ModSettingGet( "souls.testing" ) then
        GamePrint(applied_alterants_string)
    end
    GamePrint("Forge complete!")
    ComponentSetValue2(comp_stored_alterants, "value_string", stored_alterants_string)
    ComponentSetValue2(comp_applied_alterants, "value_string", applied_alterants_string)
end