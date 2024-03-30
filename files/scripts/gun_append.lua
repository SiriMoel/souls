dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")

-- this is nathan code and im not sure how it works nor really what it does nor how to use it

local _add_card_to_deck = add_card_to_deck
add_card_to_deck = function(...)
    _add_card_to_deck(...)
    if action_clone.id ~= "KUPOLI_OPEN_GATE" then return end
    local _action = action_clone.action
    target.action = function(...)
        _action(action_clone.inventory_item_id, ...)
    end
end