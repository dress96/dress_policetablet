ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('dress_policetablet:add-history',function(source, cb, data)
    
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.fetchAll("INSERT INTO suspech_policetablet (police_name,criminal_name,phone_number) VALUES (@policename,@suspendname,@phonenumber)", {
        ["@policename"] = xPlayer.getName(),
        ["@suspendname"] = data.criminalName,
        ["@phonenumber"] = data.phoneNumber,

    }, function(result)
        MySQL.Sync.execute("INSERT INTO crimes_policetablet (historyID,sanction,crimes_committed,extra_comentary) VALUES (@historyid,@sanction,@crimes,@comentary) ", {
            ["@historyid"] = result["insertId"],
            ["@sanction"] = data.assent,
            ["@crimes"] = data.crimeInformation,
            ["@comentary"] = data.extraComentary
        })
        print(result["insertId"])
    end)

    cb('ok')
end) 

ESX.RegisterServerCallback('dress_policetablet:search-history',function(source, cb, data)
    MySQL.Async.fetchAll("SELECT * FROM suspech_policetablet  WHERE criminal_name LIKE @suspendname AND isDead = 0", {
        ["@suspendname"] = data.searchHistory .. "%"
    },function(result)
        if(result[1] ~= nil) then
            print(json.encode(result))
            cb(result)
        end
    end)
end) 

ESX.RegisterServerCallback('dress_policetablet:fetch-history',function(source, cb, data)
    MySQL.Async.fetchAll("SELECT * FROM crimes_policetablet  WHERE historyID = @historyid", {
        ["@historyid"] = data.historyid
    },function(result)
        if(result[1] ~= nil) then
            print(json.encode(result))
            cb(result)
        end
    end)
end) 