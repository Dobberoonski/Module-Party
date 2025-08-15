local qualityModuleTech = data.raw["technology"]["quality-module"]
qualityModuleTech.prerequisites = nil
qualityModuleTech.enabled = true
qualityModuleTech.unit = nil
qualityModuleTech.research_trigger = {
    count = 1,
    item = "iron-plate",
    type = "craft-item"
}

local epicQualityTech = data.raw["technology"]["epic-quality"]
epicQualityTech.prerequisites = {
    "agricultural-science-pack",
    "utility-science-pack",
    "modules"
}

local qualityModuleTwoTech = data.raw["technology"]["quality-module-2"]
qualityModuleTwoTech.prerequisites = {
    "modules",
    "space-science-pack"
}

local effectReceiverAdvanced = {
    base_effect = {
        consumption = -0.05,
        speed = 0.05,
        productivity = 0.55,
        pollution = -0.05,
        quality = 0.5
    },
    uses_module_effects = true,
    uses_beacon_effects = true,
    uses_surface_effects = true
}

data.raw["assembling-machine"]["foundry"].effect_receiver = effectReceiverAdvanced
data.raw["assembling-machine"]["electromagnetic-plant"].effect_receiver = effectReceiverAdvanced
data.raw["assembling-machine"]["biochamber"].effect_receiver = effectReceiverAdvanced