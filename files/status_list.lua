dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

to_insert = {
	
}

for i,v in ipairs(to_insert) do
    table.insert(status_effects, v)
end