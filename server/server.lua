ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('stahl_policetablet:add-history',function(source, cb, data)
    
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.fetchAll("INSERT INTO stahl_policetablet (police_name,criminal_name,phone_number,sanction,crimes_committed,extra_comentary) VALUES (@policename,@suspendname,@phonenumber,@sanction,@crimes,@comentary)", {
        ["@policename"] = xPlayer.getName(),
        ["@suspendname"] = data.criminalName,
        ["@phonenumber"] = data.phoneNumber,
        ["@sanction"] = data.assent,
        ["@crimes"] = data.crimeInformation,
        ["@comentary"] = data.extraComentary
    }, function(result)
        print(json.encode(result))
    end)

    cb('ok')
end) 

ESX.RegisterServerCallback('stahl_policetablet:search-history',function(source, cb, data)

end) 