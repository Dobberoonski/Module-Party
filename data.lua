--data.lua
--[[Ass1]]
local ass1 = data.raw["assembling-machine"]["assembling-machine-1"]
ass1.module_slots = 1--we do a bit of trolling.

--[[assembling-machine]]
for k,v in pairs(data.raw["assembling-machine"]) do
    if #v.allowed_effects == 0 then return end
    --if v.module_slots == 0 then v.module_slots = 1 end
    v.quality_affects_module_slots = true
    v.quality_slots_module_bonus = {
        ["common"] = 0,
        ["uncommon"] = 1,
        ["rare"] = 2,
        ["epic"] = 3,
        ["legendary"] = 5
    }
end