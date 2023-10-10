function DebugPrint(msg)
    if Config.Debug then
        return print(msg)
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
            if Config.ChargePlayer then
                local charged = lib.callback.await('alv_repairbench:chargePlayer', false)

                if charged then
                    Config.Notify(locale('paid', Config.ChargePlayer))
                else
                    return Config.Notify(locale('not_enough_money'))
                end
            end
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
        return Config.Notify(locale('no_damage'))
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

        return Config.Notify(locale('no_metal'))
    end
end

function BeginRepair(slot)
    local slot = slot

    if lib.progressBar({
        duration = (Config.Repairing.TimeEach * 1000)/2,
        label = locale('repairing_weapon'),
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
        },
        anim = {
            dict = Config.Repairing.Fixing.AnimDict,
            clip = Config.Repairing.Fixing.AnimClip
        },
    }) then 
        if lib.progressBar({
            duration = (Config.Repairing.TimeEach * 1000)/2,
            label = locale('cleaning_weapon'),
            useWhileDead = false,
            canCancel = true,
            disable = {
                car = true,
            },
            anim = {
                dict = Config.Repairing.Cleaning.AnimDict,
                clip = Config.Repairing.Cleaning.AnimClip
            },
        }) then 
            lib.callback('alv_repairtable:repairGun', cache.serverId, function(success)
                if success then
                    Config.Notify(locale('weapon_repaired'))
                end
            end, slot)
        else 
            Config.Notify(locale('cancelled_repair'))
        end
    else 
        Config.Notify(locale('cancelled_repair'))
    end
end

if Config.Debug then
    RegisterCommand('test_noti', function()
        SendNUIMessage({
            type = 'notification',
            data = {
                message = 'Test Notification'
            }
        })
    end)

    RegisterCommand('test_ui', function()
        if not LocalPlayer.state.usingTable then
            SendNUIMessage({
                type = 'openui', 
                data = {
                    title = 'Repair Bench - Grove Street',
                    weapons = {
                        {
                            label = 'Pistol',
                            name = 'WEAPON_PISTOL', 
                            durability = 17.38
                        },
                        {
                            label = 'AP Pistol',
                            name = 'WEAPON_APPISTOL', 
                            durability = 19.21
                        }
                    } 
                }
            })
            LocalPlayer.state.usingTable = true
        else
            SendNUIMessage({
                type = 'closeui'
            })
            LocalPlayer.state.usingTable = false
        end
    end)
end
