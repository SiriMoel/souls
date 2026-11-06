local hand = GetUpdatedEntityID()

local sentinel = EntityGetRootEntity(hand)
if sentinel == hand then return end

local right_hand = EntityHasTag(hand, "hand_right")

local sent_x, sent_y = EntityGetTransform(sentinel)

local offset_x = -4
local offset_y = 5

if right_hand then 
    offset_x = offset_x * -1
end

local hand_x = sent_x + offset_x
local hand_y = sent_y + offset_y
local hand_r = 0

if right_hand then 
    hand_r = math.pi - hand_r
end

EntitySetTransform(hand, hand_x, hand_y, hand_r)