--control.lua
local function modulePartyInit()
    if not storage.moduleparty then
        storage.moduleparty = {}
    end
    if not storage.isRecipeSet then
        storage.isRecipeSet = {}
    end
end

script.on_init(modulePartyInit)
script.on_configuration_changed(modulePartyInit)

local function getRandomModule()
    --getRandomModule : -> item
    return {name="efficiency-module", count=1, quality="normal"}
end

script.on_event(defines.events.on_tick, function()--i'm sorry
    storage.isRecipeSet = storage.isRecipeSet or {}
    for _,v in pairs(storage.isRecipeSet) do
        if storage.moduleparty[v].get_recipe() ~= nil then
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
    if not storage.moduleparty[key] then return end--required if Maraxsis 1.30.49 installed.
    --see bug report: https://github.com/notnotmelon/maraxsis/issues/323
    --tl;dr Maraxsis will call this function whenever **any** entity is created. Lmfao.
    storage.moduleparty[key] = nil
end)