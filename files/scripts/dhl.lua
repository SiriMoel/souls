dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("data/scripts/gun/gun_actions.lua")

local entity = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity)

SetRandomSeed(x, y)    
math.randomseed(x, y+GameGetFrameNum())

GamePrint("hi")

local target_comp = EntityGetFirstComponentIncludingDisabled(entity, "VariableStorageComponent", "dhl_target") or 0

local targets = {}

for i,v in ipairs(actions) do
    if v.type == ACTION_TYPE_PROJECTILE then
        table.insert(targets, v)
    end
end

local target = targets[math.random(1, #targets)]

GamePrint(target.name)

--EntitySave(entity, "mods/souls/moldos.xml")

EntitySetName(entity, "Diamond " .. target.name .. " Lense")
ComponentSetValue2(target_comp, "value_string", target.id)