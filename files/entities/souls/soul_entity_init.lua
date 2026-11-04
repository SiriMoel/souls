local this = GetUpdatedEntityID()
local frame = GameGetFrameNum()
EntityAddComponent2(this, "VariableStorageComponent", {
    _tags="frame_created",
    name="frame_created",
    value_int=frame
})