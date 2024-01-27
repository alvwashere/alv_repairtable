Config = {}

Config.CheckVersion = true -- Will let you know in your console if the script is up to date and will let you know of any changelogs and things that are coming soon. 

Config.MetalItem = 'scrapmetal' -- The item required to repair weapons.
Config.ChargePlayer = 5000 -- Set this to false to make it free to repair weapons. 
Config.DrawMarker = false -- You may want to disable this if using third-eye (target). 
Config.Command = true -- If you want to use Key Mapping, Pressing E, etc. THIS MUST BE ENABLED....

Config.TableItem = {
    Prop = 'prop_tool_bench02', -- The table prop that will be placed...
    RequireMetalToPlace = true, -- Enabling this requires the player to have the MetalItem to place.
    Job = false, -- Replace false with a job if you want only specific jobs to place a table.
    TakeOnUse = true,
}

Config.KeyMapping = {
    Enabled = false, -- You'll want to disable keybinds if you're using the third eye.
    Description = 'Use a repair bench.', -- Description that will show in the FiveM keybind settings.
    Keybind = 'e'  -- The key that the repair bench will be binded to, the default and recommended is E.
}

Config.Framework = {
    Type = 'auto', --[[ Options: 'auto', 'esx', 'qb', 'ox' ]]--
    Name = 'es_extended', --[[ Name of your frameworks core resource for the export. ]]--
    Target = GetResourceState('ox_target')~='missing', -- Will determine if you have ox_target, but you can set this to false to completely disable.
    Radius = 1.0, -- The radius for the target, if enabled. 
    Icon = 'fa-solid fa-gun', -- Icon that will appear on the target.
}

Config.RepairLocations = {
    [1] = {
        Location = vec3(487.8550, -997.0225, 30.5), -- The coordinates for the bench (vector3)
        Label = 'LSPD Repair Bench', -- Label for the location you're at.
        Jobs = {
            ['police'] = true, -- Job required to operate the table, feel free to add more by adding a new line.
        },
    }
}

Config.RestrictedTo = { -- Remove the table and set this to false to allow every gun on the table
    ['WEAPON_COMBATPISTOL'] = true,
    ['WEAPON_CARBINERIFLE'] = true,
    ['WEAPON_PISTOL'] = true
}

-- EXAMPLE TO ALLOW ALL GUNS BELOW. REPLACE LINES 26-30 WITH THIS IF THATS WHAT YOU WANT.

--[[
Config.RestrictedTo = {}
]]

Config.Repairing = {
    InstantRepair = false, -- Do you want the weapon to repair instantly? Setting to false will use a progress bar and optional animation.
    TimeEach = 5, -- How long each stage should take in seconds, default is 150 seconds meaning it takes 5 minutes to repeir a weapon.
    Fixing = {
        AnimDict = 'anim@heists@prison_heiststation@cop_reactions',
        AnimClip = 'cop_b_idle'
    },
    Cleaning = {
        AnimDict = 'timetable@floyd@clean_kitchen@base',
        AnimClip = 'base'
    },
}

Config.Requirements = { -- The amount of metal required to fix a gun based on its durability.
    [99.9] = 1,
    [75] = 3,
    [50] = 6,
    [25] = 9,
    [10] = 12,
    [5] = 14,
    [0] = 15,
}

Config.MenuOptions = {
    UseMenu = false, -- --[[ OPTIONS: true (will use ox_lib menu), false (will use built-in UI) ]]--
    Title = 'Repair Bench', -- Will show in the menu header.
    Position = 'bottom-right' -- Menu position, read ox_lib docs for more positions.
}

Config.Notification = 'built-in' --[[ OPTIONS: 'built-in', 'framework', 'print', none ]]--
function Config.Notify(message)
    if Config.Notification == 'built-in' then
        SendNUIMessage({
            type = 'notification',
            data = {
                message = message,
                time = 5000,
            }
        })
    elseif Config.Notification == 'framework' then
        if ESX then
            ESX.ShowNotification(message)
        elseif QBCore then
            QBCore.Funcions.Notify(message)
        end
    elseif Config.Notification == 'print' then
        print(message)
    else return end
end

Config.Debug = false -- Will print data you can use for debugging if you modify the script, also registers some commands that'll help you test stuff. See functions file for more information.
