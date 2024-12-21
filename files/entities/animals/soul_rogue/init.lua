dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local this = GetUpdatedEntityID()
local x, y = EntityGetTransform(this)
local frame = GameGetFrameNum()

math.randomseed(x + frame, y + frame)

local soul = ""
soul = soul_types[math.random(1,#soul_types)]

if soul == "" or soul == nil then EntityKill(this) return end

EntityAddComponent2(this, "SpriteComponent", {
    image_file="mods/souls/files/entities/souls/sprites/soul_" .. soul .. ".xml",
    offset_x=0,
    offset_y=0,
})

EntityAddComponent2(this, "VariableStorageComponent", {
    _tags="soul",
    name="soul",
    value_string=soul,
})