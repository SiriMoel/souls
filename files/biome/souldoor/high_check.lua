dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")

local entity = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity )
local radius = 70

local eye = EntityGetInRadiusWithTag( x, y, radius, "evil_eye" )
local t = EntityGetFirstComponent( entity, "ParticleEmitterComponent" )

local targets = EntityGetInRadiusWithTag( x, y, radius, "player_unit" )
local targets2 = EntityGetInRadiusWithTag( x, y, radius, "tripping_extreme" )

if #eye > 0 then
    if t ~= 0 and t ~= nil then
        EntitySetComponentsWithTagEnabled( entity, "magic_eye", true )
    end
end

if #targets > 0 and #targets2 > 0 then
    if t ~= 0 and t ~= nil then
        EntitySetComponentsWithTagEnabled( entity, "magic_eye", false )
    end
    
    -- load the spell exchanger
    -- add trace
    -- add sunbook page with recipes
    -- tell the player about this!!!
end