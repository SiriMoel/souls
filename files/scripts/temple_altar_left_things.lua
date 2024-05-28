dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")

function spawn_statue( x, y )
	local curse = GameHasFlagRun( "greed_curse" )
	
	if curse then
		EntityLoad( "data/entities/misc/greed_curse/greed_crystal.xml", x, y - 48 )
		--EntityLoad( "data/entities/props/temple_statue_01_green.xml", x, y )
	else
		--EntityLoad( "data/entities/props/temple_statue_01.xml", x, y )
	end

    EntityLoad("mods/tales_of_kupoli/files/biome/soultrader/soultrader.xml", x, y)
end