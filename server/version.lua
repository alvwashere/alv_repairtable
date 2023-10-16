function mysplit(inputstr, sep) --[[ Function to split a string into an array. ]]
    if sep == nil then
        sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            table.insert(t, str)
    end
    return t
end

CreateThread( function()
    if Config.CheckVersion then
  	local version = GetResourceMetadata(GetCurrentResourceName(), 'version')
  	PerformHttpRequest('https://raw.githubusercontent.com/alvwashere/ScriptVersions/master/repairtable_version', function(code, res, headers)
  		if code == 200 then
  			local rv = json.decode(res)
  			if tonumber(table.concat(mysplit(rv.version, "."))) > tonumber(table.concat(mysplit(version, "."))) then
  					print(([[
^6[ALV-GG]^0 Repair Table Script Loaded
^6[ALV-GG]^0 The system is ^2NOT^0 up to date.
^6[ALV-GG]^0 Changelog: ^4%s ^0
]]):format(rv.version, rv.changelog))
        else
          print(([[
^6[ALV-GG]^0 Repair Table Script Loaded
^6[ALV-GG]^0 The system is ^1up to date^0.
^6[ALV-GG]^0 Changelogs: ^4%s ^0
^6[ALV-GG]^0 Coming Soon: ^4%s ^0
^6[ALV-GG]^0 Please update here: ^1https://github.com/alvwashere/alv_repairtable/releases^0.
]]):format(rv.version, rv.changelog, rv.coming_soon))
        end
  		end
  	end, 'GET')
  end
end)
