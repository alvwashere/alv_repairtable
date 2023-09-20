if not ox_inventory then local inventory = exports.ox_inventory end

function GetJob(source)
  if ESX then
    return ESX.GetPlayerFromId(source).getJob().name
  elseif QBCore then
    local Player = QBCore.Functions.GetPlayer(source)

    return Player.PlayerData.job.name
  elseif Ox then
    local player = Ox.getPlayer(source)

    return player.getGroup() -- Haven't used OX Core too much before, seeing from documentation that police and sheriff were stored as a group so that's what I'll assume is the job.
  end
end

function GetLoadout(source)
  -- no longer need framework support as the script only support ox_inventory, may as well just check count using ox_inventory functions (to follow)
end

function GetItem(source)
  local item = ox_inventory:GetItem(source, Config.MetalItem, nil, true)

  return item
end

function RemoveItem(source, count)
  -- no longer need framework support as the script only supports ox_inventory anyway, may as well just remove item using ox_inventory functions (to follow)
end
