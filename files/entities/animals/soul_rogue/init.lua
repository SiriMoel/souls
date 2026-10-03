dofile_once("mods/souls/files/scripts/souls.lua")

local this = GetUpdatedEntityID()
local x, y = EntityGetTransform(this)
local frame = GameGetFrameNum()

SetRandomSeed(x + frame, y + frame)

local soul = ""
soul = soul_types[Random(1, #soul_types - 1)]

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