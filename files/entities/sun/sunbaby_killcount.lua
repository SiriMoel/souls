dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")

local sun = GetUpdatedEntityID()
local x, y = EntityGetTransform(sun)

local targets = EntityGetInRadiusWithTag( x, y, 260, "homing_target" )

for i,target in ipairs(targets) do
    if EntityHasTag(target, "sunbaby_target") ~= true then
        EntityAddComponent2(target, "LuaComponent", {
            script_death = "mods/tales_of_kupoli/files/entities/sun/sunbaby_killcount_death.lua",
			execute_every_n_frame = -1,
        })
    end
end