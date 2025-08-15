--data.lua
local qualitySlotsModuleBonus = {--TODO: mod settings
    ["normal"] = 0,
    ["uncommon"] = 1,
    ["rare"] = 2,
    ["epic"] = 3,
    ["legendary"] = 5
}

local affectedEntityTypes = {
    "assembling-machine",
    "mining-drill",
    "lab",
    "furnace",
    "beacon"
}

local allowedEffects = {
    "productivity",
    "consumption",
    "quality",
    "speed",
    "pollution"
}

local effectReceiver = {
    base_effect = {
        consumption = -0.05,
        speed = 0.05,
        productivity = 0.05,
        pollution = -0.05,
        quality = 0.5
    },
    uses_module_effects = true,
    uses_beacon_effects = true,
    uses_surface_effects = true
}

data.raw["assembling-machine"]["assembling-machine-1"].module_slots = 1--we do a little bit of trolling.
data.raw["assembling-machine"]["captive-biter-spawner"].module_slots = 1--ok we do a lot of trolling.
data.raw["mining-drill"]["burner-mining-drill"].module_slots = 1--absolutely humongous levels of trolling.
data.raw["furnace"]["stone-furnace"].module_slots = 1--gigantamaxx trolling.
data.raw["furnace"]["steel-furnace"].module_slots = 2--trollface.png
data.raw["furnace"]["electric-furnace"].module_slots = 3--i bet you thought i was done lol

for _,entityType in pairs(affectedEntityTypes) do
    for __,entity in pairs(data.raw[entityType]) do
        entity.quality_affects_module_slots = true
        entity.quality_slots_module_bonus = qualitySlotsModuleBonus
        entity.allowed_effects = allowedEffects
        entity.effect_receiver = effectReceiver
    end
end

for _,recipe in pairs(data.raw.recipe) do
    recipe.allow_consumption = true
    recipe.allow_speed = true
    recipe.allow_productivity = true
    recipe.allow_pollution = true
    recipe.allow_quality = true
end