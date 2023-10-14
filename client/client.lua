lib.locale()

for k, v in pairs(Config.RepairLocations) do
    local point = lib.points.new({
        coords = v.Location,
        distance = 2.0,
        dunak = v.Label,
    })

    function point:nearby()
        DrawMarker(2, v.Location, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.25, 0.15, 200, 30, 30, 200, false, true, 2, nil, nil, false)
    end

    function point:onExit()
        if lib.getOpenMenu() == 'repair_bench' then
            lib.hideMenu()
        end
    end
end

RegisterCommand('repair_bench', function()
    local failAttempts = 0
    local Weapons = {}
    local location = nil

    for k, v in pairs(Config.RepairLocations) do
        if #(GetEntityCoords(cache.ped) - v.Location) > 3.0 then
            failAttempts = failAttempts + 1
            location = v.Label

            if failAttempts >= #Config.RepairLocations then
                return
            end
        end
    end

    local allowed = lib.callback.await('alv_repairtable:canUse', false)

    if allowed then
        local loadout = lib.callback.await('alv_repairtable:getLoadout', false)

        for k, v in pairs(loadout) do
            if string.find(v.name, 'WEAPON_') then
                if Config.RestrictedTo and Config.RestrictedTo[v.name] then
                    Weapons[#Weapons+1] = {label=v.label, description=locale('menu_description', v.label, v.metadata.durability), args={name = v.name, durability=v.metadata.durability, slot=v.slot}}
                elseif Config.RestrictedTo == false then
                    Weapons[#Weapons+1] = {label=v.label, description=locale('menu_description', v.label, v.metadata.durability), args={name = v.name, durability=v.metadata.durability, slot=v.slot}}
                end
            end
        end

        if #Weapons > 0 then
            DebugPrint(json.encode(Weapons, {indent=true}))

            BeginMenu(Weapons, location)
        else
            Config.Notify(locale('no_weapons'))
        end
    else
        Config.Notify(locale('no_job'))
    end
end)

RegisterKeyMapping('repair_bench', 'Use a repair bench.', 'keyboard', Config.Bind)

AddEventHandler('onResourceStop', function(name)
    if name == GetCurrentResourceName() then
        if lib.getOpenMenu() == 'repair_bench' then
            lib.hideMenu()
        end
    end
end)
