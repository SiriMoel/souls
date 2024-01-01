dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")

local player = GetUpdatedEntityID()
local x, y = EntityGetTransform(player)

local radius = 100

SetRandomSeed(x,y+GameGetFrameNum())

local targets = EntityGetInRadiusWithTag( x, y, radius, "homing_target" )

if ( #targets > 0 ) then
    --for i,target_id in ipairs( targets ) do
    for i=1,#targets do

        if EntityHasTag(targets[i], "auto_reap_marked") == false and EntityHasTag(targets[i], "reap_marked") == false then

            if math.random(1,5) == 2 then
                EntityAddComponent( targets[i], "LuaComponent",
                {
                    script_death = "mods/tales_of_kupoli/files/scripts/reap.lua",
                    execute_every_n_frame = "-1",
                } )
    
                --local effect_id = EntityLoad("mods/tales_of_kupoli/files/entities/particles/marked_particles.xml", x, y)
                --EntityAddChild( targets[i], effect_id )
                EntityAddTag( targets[i], "reap_marked")
            end

            EntityAddTag( targets[i], "auto_reap_marked")
        end
    end
end