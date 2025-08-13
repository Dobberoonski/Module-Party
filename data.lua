--data.lua
--[[assembling-machine-1]]
data.raw["assembling-machine"]["assembling-machine-1"].module_slots = 1--we do a bit of trolling.

--[[assembling-machine]]
for k,v in pairs(data.raw["assembling-machine"]) do
    if #v.allowed_effects == 0 then return end
    v.quality_affects_module_slots = true
    v.quality_slots_module_bonus = {
        ["normal"] = 0,
        ["uncommon"] = 1,
        ["rare"] = 2,
        ["epic"] = 3,
        ["legendary"] = 5
    }
    v.created_effect = {
        type = "direct",
        action_delivery = {
            type = "instant",
            source_effects = {
                type = "script",
                effect_id = "get-ready-to-party"
            }
        }
    }
end