local ox_inventory = exports.ox_inventory

lib.callback.register('alv_repairtable:canUse', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)

    for k, v in pairs(Config.RepairLocations) do
        if #(v.Location - GetEntityCoords(GetPlayerPed(source))) < 2.0 then
            if v.Jobs and type(v.Jobs == 'table') and v.Jobs[xPlayer.getJob().name] then
                return true
            end
        end
    end

    return false
end)

lib.callback.register('alv_repairtable:getLoadout', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)

    return xPlayer.getInventory()
end)

lib.callback.register('alv_repairtable:getMetal', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)

    return xPlayer.getInventoryItem(Config.MetalItem).count
end)

lib.callback.register('alv_repairtable:removeMetal', function(source, count)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getInventoryItem(Config.MetalItem).count >= count then
        xPlayer.removeInventoryItem(Config.MetalItem, count)
        return true
    end
end)

lib.callback.register('alv_repairtable:repairGun', function(source, slot, cb)
    if source and slot then
        local xPlayer = ESX.GetPlayerFromId(source)
        
        ox_inventory:SetDurability(source, slot, 100)
        return true
    end
end)
