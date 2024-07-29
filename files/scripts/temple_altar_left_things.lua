dofile_once("mods/souls/files/scripts/utils.lua")

function spawn_statue( x, y )
	local curse = GameHasFlagRun( "greed_curse" )
	
	if curse then
		EntityLoad( "data/entities/misc/greed_curse/greed_crystal.xml", x, y - 48 )
		--EntityLoad( "data/entities/props/temple_statue_01_green.xml", x, y )
	else
		--EntityLoad( "data/entities/props/temple_statue_01.xml", x, y )
	end

    EntityLoad("mods/souls/files/biome/soultrader/soultrader.xml", x, y)
end