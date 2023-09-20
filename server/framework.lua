CreateThread(function()
  if Config.Framework.Type == 'auto' then
    if GetResourceState('es_extended') ~= 'missing' then
      ESX = exports['es_extended']:getSharedObject()
    elseif GetResourceState('qb-core') ~= 'missing' then
      QBCore = exports['qb-core']:GetCoreObject()
    elseif GetResourceState('ox_core') ~= 'missing' then
      local file = ('imports/%s.lua'):format(IsDuplicityVersion() and 'server' or 'client')
      local import = LoadResourceFile('ox_core', file)
      local chunk = assert(load(import, ('@@ox_core/%s'):format(file)))
      chunk()
    end
  end
end)
