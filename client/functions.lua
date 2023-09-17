function DebugPrint(msg)
    if Config.DebugPrint then
        print(msg)
    end
end

function BeginMenu(weapons)
    lib.registerMenu({
        id='repair_bench',
        title=Config.MenuOptions.Title, 
        position=Config.MenuOptions.Position,
        options=weapons
    }, function(selected, scrollIndex, args)
        if CanRepair(args.durability) then
            BeginRepair(args.slot)
        end
    end)

    Wait(100)

    if not lib.getOpenMenu() then
        lib.showMenu('repair_bench')
    end
end

function CanRepair(durability)
    if durability == 100 then
        return ESX.ShowNotification('This weapon has no damage to repair.')
    else
        local metalCount = lib.callback.await('alv_repairtable:getMetal', false)

        for k, v in pairs(Config.Requirements) do
            if durability >= k and metalCount >= v then
                local success = lib.callback.await('alv_repairtable:removeMetal', false, v)

                if success then
                    return true
                end
            end
        end

        return ESX.ShowNotification('You do not have enough metal to repair this gun.')
    end
end

function BeginRepair(slot)
    local slot = slot

    if lib.progressBar({
        duration = (Config.Duration * 1000)/2,
        label = 'Repairing Weapon...',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
        },
        anim = {
            dict = 'anim@heists@prison_heiststation@cop_reactions',
            clip = 'cop_b_idle'
        },
    }) then 
        if lib.progressBar({
            duration = (Config.Duration * 1000)/2,
            label = 'Cleaning Weapon...',
            useWhileDead = false,
            canCancel = true,
            disable = {
                car = true,
            },
            anim = {
                dict = 'timetable@floyd@clean_kitchen@base',
                clip = 'base'
            },
        }) then 
            lib.callback('alv_repairtable:repairGun', cache.serverId, function(success)
                if success then
                    ESX.ShowNotification('Weapon Repaired...')
                end
            end, slot)
        else 
            ESX.ShowNotification('Cancelled repair...')
        end
    else 
        ESX.ShowNotification('Cancelled repair...')
    end
end