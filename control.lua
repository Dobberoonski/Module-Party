--control.lua
local function ModuleParty_Init()
    if not storage.moduleparty then
        storage.moduleparty = {}
    end
    if not storage.isRecipeSet then
        storage.isRecipeSet = {}
    end
end

local function getRandomModule()
    --getRandomModule : -> item
    return {name="efficiency-module", count=1, quality="normal"}
end

script.on_init(ModuleParty_Init)
script.on_configuration_changed(ModuleParty_Init)

script.on_event(defines.events.on_tick, function()--i'm sorry
    storage.isRecipeSet = storage.isRecipeSet or {}
    for _,v in pairs(storage.isRecipeSet) do
        if storage.moduleparty[v].get_recipe() ~= nil then--crashes on mining-drill
            storage.isRecipeSet[_] = nil
            while(storage.moduleparty[v].get_module_inventory().is_full() == false) do
                storage.moduleparty[v].get_module_inventory().insert(getRandomModule())
            end
        end
    end
end)

script.on_event(defines.events.on_script_trigger_effect, function(event)
    if event.effect_id ~= "get-ready-to-party" then return end
    local key = script.register_on_object_destroyed(event.source_entity)
    table.insert(storage.isRecipeSet, key)
    storage.moduleparty[key] = event.source_entity
end)

script.on_event(defines.events.on_object_destroyed, function(event)
    local key = event.registration_number
    if not storage.moduleparty[key] then return end--prevent potential mod compatibility issues
    storage.moduleparty[key] = nil
end)