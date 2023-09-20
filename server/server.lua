local ox_inventory = exports.ox_inventory

lib.callback.register('alv_repairtable:canUse', function(source, cb)
    for k, v in pairs(Config.RepairLocations) do
        if #(v.Location - GetEntityCoords(GetPlayerPed(source))) < 2.0 then
            if v.Jobs and type(v.Jobs == 'table') and v.Jobs[GetJob(source)] then
                return true
            end
        end
    end

    return false
end)

lib.callback.register('alv_repairtable:getLoadout', function(source, cb)
    return GetLoadout(source)
end)

lib.callback.register('alv_repairtable:getMetal', function(source, cb)
    return GetItem(source)
end)

lib.callback.register('alv_repairtable:removeMetal', function(source, count)
    RemoveItem(source, count)
end)

lib.callback.register('alv_repairtable:repairGun', function(source, slot, cb)
    if source and slot then
        ox_inventory:SetDurability(source, slot, 100)
        return true
    end
end)
