local this = GetUpdatedEntityID()
local x, y = EntityGetTransform(this)
local comp = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "souls_boss_to_revive")
if comp == nil then print("Souls?") return end
local path = ComponentGetValue2(comp, "value_string")
local boss = EntityLoad(path, x, y)
GamePlaySound("data/audio/Desktop/projectiles.bank", "projectiles/enlightened_laser/launch_dark", x, y)
GamePlaySound("data/audio/Desktop/misc.bank", "misc/chest_dark_open", x, y)
GameScreenshake(30)