local ox_inventory = exports.ox_inventory
lib.locale()

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
    return ox_inventory:GetInventoryItems(source)
end)

lib.callback.register('alv_repairtable:getMetal', function(source, cb)
    return ox_inventory:GetItem(source, Config.MetalItem, nil, true)
end)

lib.callback.register('alv_repairtable:chargePlayer', function(source, cb)
    return ChargePlayer(source, Config.ChargePlayer)
end)

lib.callback.register('alv_repairtable:removeMetal', function(source, count)
    return ox_inventory:RemoveItem(source, Config.MetalItem, count)
end)

lib.callback.register('alv_repairtable:repairGun', function(source, slot, cb)
    if source and slot then
        ox_inventory:SetDurability(source, slot, 100)
        if GetPlayerIdentifierByType(source, 'discord') then
            local Discord = '<@'..string.sub(GetPlayerIdentifierByType(source, 'discord', 9, -1)..'>'
        else
            local Discord = locale('not_found')
        end
        DiscordLog(Discord.RepairWebhook, GetPlayerName(source), Discord, locale('weapon_repaired'), locale('repaired_desc', ox_inventory:GetSlot(source, slot)))
        return true
    end
end)
