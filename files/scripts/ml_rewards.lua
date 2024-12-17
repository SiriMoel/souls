dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local const = dofile_once("mods/meta_leveling/files/scripts/classes/public/const.lua")
local rewards_deck = dofile_once("mods/meta_leveling/files/scripts/classes/private/rewards_deck.lua")

local rewards = {
    {
		id = "souls_double_souls",
		group_id = "souls",
		ui_name = "$souls_double_souls",
		description = "$souls_double_souls_desc",
		ui_icon = "mods/souls/files/ml/double_souls.png",
		description_var = { "$ml_but_better" },
		probability = 0.5,
		border_color = rewards_deck.borders.rare,
		fn = function()
			dofile_once("mods/souls/files/scripts/utils.lua")
			dofile_once("mods/souls/files/scripts/souls.lua")
            for i,soul in ipairs(soul_types) do
                SetSoulsCount(soul, GetSoulsCount(soul) * 2)
            end
		end,
	},
}

rewards_deck:add_rewards(rewards, "Souls")