local this = GetUpdatedEntityID()
local x, y = EntityGetTransform(this)
GamePlaySound("data/audio/Desktop/animals.bank", "animals/generic/bite", x, y)
GamePlaySound("data/audio/Desktop/projectiles.bank", "projectiles/enlightened_laser/launch_dark", x, y)