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

data.raw["assembling-machine"]["foundry"].effect_receiver.base_effect.productivity = 0.55
data.raw["assembling-machine"]["electromagnetic-plant"].effect_receiver.base_effect.productivity = 0.55
data.raw["assembling-machine"]["biochamber"].effect_receiver.base_effect.productivity = 0.55