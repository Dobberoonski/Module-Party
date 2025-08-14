--control.lua
local printSettings = {sound = defines.print_sound.never}

local function getRandomModule()
    return {name="efficiency-module", count=1, quality="normal"}
end

script.on_event(defines.events.on_built_entity, function(event)
    game.print("on_built_entity")
    while(event.entity.get_module_inventory().is_full() == false) do
        event.entity.get_module_inventory().insert(getRandomModule())
        game.print("inserted module")
    end
end)

script.on_event(defines.events.on_pre_player_mined_item, function(event)
    game.print("on_pre_player_mined_item")
    event.entity.get_module_inventory().clear()
    game.print("cleared modules")
end)