--control.lua
local affectedEntityTypes = {
    "assembling-machine",
    "mining-drill",
    "lab",
    "furnace",
    "beacon"
}

local moduleTier = {"", "-2", "-3"}

--Adds support for mods that add/remove module categories (prod, speed, etc)
local moduleName = {}
for _,m in pairs(prototypes.module_category) do
    repeat
        if m.name == "ai-speed" then break end--preclude Moshine's ai-speed-module-x
        if m.name == "kr-ai-core" then break end--preclude K2SO's/Moshine's kr-ai-core-module-x
        table.insert(moduleName, m.name)
    until true
end

--Adds support for mods that extend quality tiers
local moduleQuality = {}
for _,q in pairs(prototypes.quality) do
    table.insert(moduleQuality, q.name)
end

local lenName = #moduleName
local lenTier = #moduleTier
local lenQuality = #moduleQuality

local function isAffectedEntityType(entityType)
    --isAffectedEntityType : entity.type -> bool
    for _,t in pairs(affectedEntityTypes) do
        if entityType == t then return true end
    end
    return false
end

local function isCompatibleEntity(entityName)
    --isCompatibleEntity : entity -> bool
    if script.active_mods["Moshine"] ~= nil then
        --Preclude special Moshine buildings that only take ai-speed modules
        return not prototypes.entity[entityName].allowed_module_categories["ai-speed"]
    end
    return true
end

local function getRandomModule()
    --getRandomModule : -> table
    return {
        name=moduleName[math.random(lenName)].. "-module".. moduleTier[math.random(lenTier)],
        count=1,
        quality=moduleQuality[math.random(lenQuality)]
    }
end

local function addModulesToEntity(entity)
    --pullthrough helper function
    if not isAffectedEntityType(entity.type) then return false end
    if not isCompatibleEntity(entity.name) then return false end
    while(entity.get_module_inventory().is_full() == false) do
        entity.get_module_inventory().insert(getRandomModule())
    end
end

local function removeModulesFromInventory(inventory)
    --removeModulesFromInventory : defines.inventory -> 
    items = inventory.get_contents()--item = {name, count, quality}
    for _,item in pairs(items) do
        if string.find(item.name, "-module") then inventory.remove(item) end
    end
end

script.on_event(defines.events.on_built_entity, function(event)
    addModulesToEntity(event.entity)
end)

script.on_event(defines.events.on_robot_built_entity, function(event)
    addModulesToEntity(event.entity)
end)

script.on_event(defines.events.on_pre_player_mined_item, function(event)
    if not isAffectedEntityType(event.entity.type) then return false end
    event.entity.get_module_inventory().clear()
end)

script.on_event(defines.events.on_marked_for_deconstruction, function(event)
    if not isAffectedEntityType(event.entity.type) then return false end
    event.entity.get_module_inventory().clear()
end)

script.on_event(defines.events.on_player_main_inventory_changed, function(event)
    removeModulesFromInventory(game.get_player(event.player_index).get_inventory(defines.inventory.character_main))
end)

script.on_event(defines.events.on_player_trash_inventory_changed, function(event)
    removeModulesFromInventory(game.get_player(event.player_index).get_inventory(defines.inventory.character_trash))
end)