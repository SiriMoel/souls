dofile_once("mods/souls/files/scripts/utils.lua")

local entity = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity )
local radius = 70

function SpawnExchanger(x, y)
    EntityLoad("mods/souls/files/biome/souldoor/exchanger.xml", x, y)

    lx = x - 60
    ly = y

    local light1 = EntityLoad("mods/souls/files/biome/souldoor/exchanger_light_1.xml", lx, ly)
    
    lx = lx + 30
    local light2 = EntityLoad("mods/souls/files/biome/souldoor/exchanger_light_2.xml", lx, ly)
    
    lx = lx + 60
    local light3 = EntityLoad("mods/souls/files/biome/souldoor/exchanger_light_3.xml", lx, ly)

    lx = lx + 30
    local light4 = EntityLoad("mods/souls/files/biome/souldoor/exchanger_light_4.xml", lx, ly)
end

local eyes = EntityGetInRadiusWithTag( x, y, radius, "evil_eye" )
local found = false

if ( #eyes > 0 ) then
	for i,v in ipairs( eyes ) do
		local t = EntityGetFirstComponent( v, "LightComponent", "magic_eye_check" )
		
		if ( t ~= nil ) then
			found = true
			break
		end
	end
end

local t = EntityGetFirstComponent( entity, "ParticleEmitterComponent" )

local targets = EntityGetInRadiusWithTag( x, y, radius, "player_unit" )
local targets2 = EntityGetInRadiusWithTag( x, y, radius, "tripping_extreme" )

if found then
    if t ~= 0 and t ~= nil then
        EntitySetComponentsWithTagEnabled( entity, "magic_eye", true )
    end
end

if #targets > 0 and #targets2 > 0 then
    if t ~= 0 and t ~= nil then
        EntitySetComponentsWithTagEnabled( entity, "magic_eye", false )
        EntityRemoveComponent( entity, EntityGetFirstComponent( entity, "ParticleEmitterComponent" ) or 0)
    end

    if not EntityHasTag(entity, "activated") then
        SpawnExchanger(x, y-60)
        EntityAddTag(entity, "activated")
    end
end