Config = {}

Config.MetalItem = 'scrapmetal' -- The item required to repair weapons.
Config.Duration = 600 -- The amount of time it will take to repair weapons in seconds. (Default 5 minutes.)

Config.RepairLocations = {
    [1] = {
        Location = vec3(-97.6829, -1791.9990, 26.9096), -- The coordinates for the bench (vector3)
        Label = 'LCF Bench', -- Label for the location you're at.
        Jobs = {
            'mechanic', -- Job required to operate the table, feel free to add more by adding a new line.
        }
    }
}

Config.Repairing = {
    InstantRepair = false, -- Do you want the weapon to repair instantly? Setting to false will use a progress bar and optional animation.

}

Config.Requirements = { -- The amount of metal required to fix a gun based on its durability.
    [75] = 3,
    [50] = 6,
    [25] = 9,
    [10] = 12,
    [5] = 14,
    [0] = 15,
}

Config.MenuOptions = {
    Title = 'Repair Bench', -- Will show in the menu header.
    Position = 'bottom-right' -- Menu position, read ox_lib docs for more positions.
}

Config.DebugPrint = false -- Will print data you can use for debugging if you modify the script.