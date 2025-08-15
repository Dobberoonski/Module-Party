--control.lua
local affectedEntityTypes = {
    "assembling-machine",
    "mining-drill",
    "lab",
    "furnace"
}

local function isAffectedEntityType(entityType)
    --isAffectedEntityType : entity.type -> bool
    for _,t in pairs(affectedEntityTypes) do
        if entityType == t then return true end
    end
    return false
end

local function getRandomModule()
    return {name="efficiency-module", count=1, quality="normal"}
end

script.on_event(defines.events.on_built_entity, function(event)
    --game.print("Name: ".. event.entity.name.. " Type: ".. event.entity.type)
    if not isAffectedEntityType(event.entity.type) then return false end
    while(event.entity.get_module_inventory().is_full() == false) do
        event.entity.get_module_inventory().insert(getRandomModule())
    end
end)

script.on_event(defines.events.on_pre_player_mined_item, function(event)
    if not isAffectedEntityType(event.entity.type) then return false end
    event.entity.get_module_inventory().clear()
end)