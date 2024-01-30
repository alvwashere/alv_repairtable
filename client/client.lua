lib.locale()

for k, v in pairs(Config.RepairLocations) do
    local point = lib.points.new({
        coords = v.Location,
        distance = 2.0,
        dunak = v.Label,
    })

    if Config.DrawMarker then
        function point:nearby()
            DrawMarker(2, v.Location, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.25, 0.15, 200, 30, 30, 200, false, true, 2, nil, nil, false)
        end
    end

    if Config.Framework.Target then
        function point:onEnter()
            repair_bench_target = exports.ox_target:addSphereZone({
                coords = v.Location,
                radius = Config.Framework.Radius,
                debug=Config.Debug,
                options = {
                    {
                        name = 'alv_repairbench',
                        icon = Config.Framework.Icon,
                        label = v.Label,
                        onSelect = function()
                            repairBench()
                        end
                    }
                }
            })
        end
    end

    function point:onExit()
        if lib.getOpenMenu() == 'repair_bench' then
            lib.hideMenu()
        end

        if Config.Framework.Target then
            exports.ox_target:removeZone(repair_bench_target)
        end
    end
end

function repairBench(portable)
    local failAttempts = 0
    local Weapons = {}
    local location = nil

    if not portable then
        for k, v in pairs(Config.RepairLocations) do
            if #(GetEntityCoords(cache.ped) - v.Location) > 3.0 then
                failAttempts = failAttempts + 1
                location = v.Label

                if failAttempts >= #Config.RepairLocations then
                    return
                end
            end
        end
    end

    local allowed = portable or lib.callback.await('alv_repairtable:canUse', false)

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
end

if Config.Command and Config.KeyMapping.Enabled then
    RegisterCommand('repair_bench', function()
        repairBench()
    end)
end

if Config.KeyMapping.Enabled then
    RegisterKeyMapping('repair_bench', Config.KeyMapping.Description, 'keyboard', Config.Keymapping.Keybind)
end

RegisterNetEvent('alv_repairtable:placeTable', function()
    if Config.TableItem.RequireMetalToPlace then
        local hasMetal = lib.callback.await('alv_repairtable:getMetal', false)

        if hasMetal == 0 then
            return Config.Notify(locale('no_metal_placing'))
        end
    end

    if Config.TableItem.Job then
        local allowed = lib.callback.await('alv_repairtable:canPlace', false)

        if not allowed then return Config.Notify(locale('no_job_placing')) end
    end

    if Config.TableItem.TakeOnUse then
        lib.callback.await('alv_repairtable:takeTable', false, 'place')
    end

    local tableHash = GetHashKey(Config.TableItem.Prop)
    RequestModel(tableHash)

    while not HasModelLoaded(tableHash) do
        Wait(0)
    end

    local x, y, z = table.unpack(GetEntityCoords(cache.ped))
    local table = CreateObject(tableHash, x + 2.0, y, z, true, true, true)
    PlaceObjectOnGroundProperly(table)

    function DeleteTable()
        SetEntityAsMissionEntity(table)
        DeleteObject(table)
    end

    local table_point = lib.points.new({
        coords = GetEntityCoords(table),
        distance = 2.0, 
        dunake = 'nerd',
    })

    function table_point:onEnter()
        portable_table = exports.ox_target:addSphereZone({
            coords = GetEntityCoords(table),
            radius = Config.Framework.Radius,
            debug = Config.Debug,
            options = {
                {
                    name = 'alv_useBench',
                    label = locale('use_repair_bench'), 
                    icon = Config.Framework.Icon,
                    onSelect = function()
                        repairBench(true)
                    end
                },
                {
                    name = 'alv_takeBench',
                    label = locale('pick_bench_up'), 
                    icon = Config.Framework.Icon,
                    onSelect = function()
                        DeleteTable()

                        if Config.TableItem.TakeOnUse then
                            lib.callback.await('alv_repairtable:takeTable', false, 'pickup')

                            exports.ox_target:removeZone(portable_table)
                            table_point = nil
                        end
                    end
                },
            }
        })
    end

    function table_point:onExit()
        exports.ox_target:removeZone(portable_table)
    end
end)

AddEventHandler('onResourceStop', function(name)
    if name == GetCurrentResourceName() then
        if lib.getOpenMenu() == 'repair_bench' then
            lib.hideMenu()
        end
    end
end)
