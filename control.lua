--control.lua
local affectedEntityTypes = {
    "assembling-machine",
    "mining-drill",
    "lab",
    "furnace",
    "beacon"
}

local moduleName = {"productivity", "efficiency", "speed", "quality"}
local moduleTier = {"", "-2", "-3"}
local moduleQuality = {"normal", "uncommon", "rare", "epic", "legendary"}

local function isAffectedEntityType(entityType)
    --isAffectedEntityType : entity.type -> bool
    for _,t in pairs(affectedEntityTypes) do
        if entityType == t then return true end
    end
    return false
end

local function getRandomModule()
    --getRandomModule : -> table
    return {
        name=moduleName[math.random(4)].. "-module".. moduleTier[math.random(3)],
        count=1,
        quality=moduleQuality[math.random(5)]
    }
end

script.on_event(defines.events.on_built_entity, function(event)
    if not isAffectedEntityType(event.entity.type) then return false end
    while(event.entity.get_module_inventory().is_full() == false) do
        event.entity.get_module_inventory().insert(getRandomModule())
    end
end)

script.on_event(defines.events.on_pre_player_mined_item, function(event)
    if not isAffectedEntityType(event.entity.type) then return false end
    event.entity.get_module_inventory().clear()
end)