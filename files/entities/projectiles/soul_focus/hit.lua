dofile_once("mods/souls/files/scripts/souls.lua")

local this = GetUpdatedEntityID()
local root = EntityGetRootEntity(this)

local c = EntityGetAllChildren(root, "souls_effect_focus") or {}
if #c == 0 then
    local player = EntityGetWithTag("player_unit")[1]
    local success, soul = SpellUseSouls(player, 1)
    if success then
        if GlobalsGetValue("souls.say_consumed_soul", "true") == "true" then
		    local soul_name = GameTextGetTranslatedOrNot(soul_names[soul])
    		GamePrint("A " .. soul_name .. " soul was consumed!")
	    end
        local effect = LoadGameEffectEntityTo(root, "mods/souls/files/entities/projectiles/soul_focus/effect.xml")
        EntityAddComponent2(effect, "SpriteComponent", {
            image_file="mods/souls/files/entities/souls/sprites/soul_" .. soul .. ".xml",
        })
    end
end

EntityKill(this)