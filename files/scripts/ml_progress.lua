dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local meta = dofile_once("mods/meta_leveling/files/scripts/classes/private/meta.lua")

local progress = {
    {
		id = "souls_starting_souls",
		ui_name = "$souls_starting_souls",
		description = "$souls_starting_souls_desc",
		fn = function(count)
            dofile_once("mods/souls/files/scripts/utils.lua")
			dofile_once("mods/souls/files/scripts/souls.lua")
            for i=1,count do
                AddSouls(GetRandomSoulType(false), 1)
            end
            --AddRandomSouls(count, false)
		end,
		applied_bonus = function(count)
			return "+" .. 1 * count
		end,
		stack = 100,
		price = 2,
		price_multiplier = 1.1,
	},
}

meta:append_points(progress, "Souls")