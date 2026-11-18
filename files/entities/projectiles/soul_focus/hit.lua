dofile_once("mods/souls/files/scripts/souls.lua")

local this = GetUpdatedEntityID()
local root = EntityGetRootEntity(this)

local c = EntityGetAllChildren(root, "souls_effect_focus") or {}
if #c == 0 then
    local player = EntityGetWithTag("player_unit")[1]
    local success, soul = SpellUseSouls(player, 1)
    if success then

        SoulsPrint("A " .. GameTextGetTranslatedOrNot(soul_names[soul]) .. " soul was consumed!", "say_consumed_soul")
        local effect = LoadGameEffectEntityTo(root, "mods/souls/files/entities/projectiles/soul_focus/effect.xml")
        EntityAddComponent2(this, "SpriteComponent", {
            image_file = "mods/souls/files/soul_sprites/souls.xml",
            rect_animation = soul .. "_a",
            offset_x = 5,
            offset_y = 5,
        })
    end
end

EntityKill(this)