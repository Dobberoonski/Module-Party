--data.lua
local qualitySlotsModuleBonus = {--TODO: mod settings
    ["normal"] = 0,
    ["uncommon"] = 1,
    ["rare"] = 2,
    ["epic"] = 3,
    ["legendary"] = 5
}

local getReadyToParty = {--made redundant
    type = "direct",
    action_delivery = {
        type = "instant",
        source_effects = {
            type = "script",
            effect_id = "get-ready-to-party"
         }
    }
}

local affectedEntityTypes = {
    "assembling-machine",
    "mining-drill",
    "lab",
    "furnace"
}

local allowedEffects = {
    "productivity",
    "consumption",--you'd think it'd be called "efficiency". Nah.
    "quality",
    "speed",
    "pollution"
    --Failed to load mods: Error while loading entity prototype "burner-mining-drill" (mining-drill): Unknown effect string: efficiency
    --bruhmoment.mp4
}

--[[assembling-machine-1]]
data.raw["assembling-machine"]["assembling-machine-1"].module_slots = 1--we do a little bit of trolling.

--[[captive-biter-spawner]]
local captiveBiterSpawner = data.raw["assembling-machine"]["captive-biter-spawner"]
captiveBiterSpawner.module_slots = 1--ok we do a lot of trolling.
captiveBiterSpawner.allowed_effects = allowedEffects

--[[burner-mining-drill]]
local burnerMiningDrill = data.raw["mining-drill"]["burner-mining-drill"]
burnerMiningDrill.module_slots = 1--absolutely humongous levels of trolling.
burnerMiningDrill.allowed_effects = allowedEffects

--[[stone/steel-furnace]]
local stoneFurnace = data.raw["furnace"]["stone-furnace"]
stoneFurnace.module_slots = 1--gigantamaxx trolling.
stoneFurnace.allowed_effects = allowedEffects
local steelFurnace = data.raw["furnace"]["steel-furnace"]
steelFurnace.module_slots = 2--trollface.png
steelFurnace.allowed_effects = allowedEffects
data.raw["furnace"]["electric-furnace"].module_slots = 3--i bet you thought i was done lol

for _,entityType in pairs(affectedEntityTypes) do
    for __,entity in pairs(data.raw[entityType]) do
        entity.quality_affects_module_slots = true
        entity.quality_slots_module_bonus = qualitySlotsModuleBonus
        --entity.created_effect = getReadyToParty
    end
end

for _,recipe in pairs(data.raw.recipe) do
    recipe.allow_consumption = true
    recipe.allow_speed = true
    recipe.allow_productivity = true
    recipe.allow_pollution = true
    recipe.allow_quality = true
end