dofile_once("mods/souls/files/scripts/souls.lua")

local this = GetUpdatedEntityID()
local root = EntityGetRootEntity(this)
local x, y = EntityGetTransform(root)

if root == this then 
    GamePrint("Souls?")
    EntityKill(this)
    return 
end

local fx = EntityGetAllChildren(root, "souls_reap_fx") or {}
if #fx == 0 then
    local fx_e = EntityLoad("mods/souls/files/entities/misc/reapers/fx.xml", x, y)
    EntityAddChild(root, fx_e)
end

local comp_death = EntityGetFirstComponent(root, "LuaComponent", "souls_reap_death")
if comp_death == nil then
    EntityAddComponent2(root, "LuaComponent", {
        _tags="souls_reap_death",
        script_death="mods/souls/files/entities/misc/reapers/reap_death.lua",
        execute_every_n_frame=-1
    })
end

local comp = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "souls_reaper")
if comp ~= nil then
    local soul = "friendly"
    local amt = 1
    local c_soul = ComponentGetValue2(comp, "name")
    local c_amt = ComponentGetValue2(comp, "value_int")
    if c_soul == "soul" then
        soul = GetEntitySoulType(root)
        amt = c_amt
        EntityAddComponent2(root, "VariableStorageComponent", {
            _tags="souls_reap",
            name=soul,
            value_int=amt
        })
    elseif c_soul == "random" then
        SetRandomSeed(x, y)
        for i=1,c_amt do
            local r_soul = soul_types[Random(1, #soul_types - 2)]
            EntityAddComponent2(root, "VariableStorageComponent", {
                _tags="souls_reap",
                name=r_soul,
                value_int=1
            })
        end
    elseif soul_names[c_soul] ~= nil then
        soul = c_soul
        amt = c_amt
        EntityAddComponent2(root, "VariableStorageComponent", {
            _tags="souls_reap",
            name=soul,
            value_int=amt
        })
    end
end