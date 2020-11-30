ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local display = false

RegisterCommand("pda", function(source, args)
    SetTablet(not display)
end)


RegisterNUICallback("main",function(data)
    chat(data.text{0,255,0})
    SetTablet(false)
end)

RegisterNUICallback("error",function(data)
    chat(data.error, {255,0,0})
    SetTablet(false)
end)

RegisterNUICallback("exit",function(data)
    SetTablet(false)
end)

Citizen.CreateThread(function()

    while display do
        Citizen.Wait(0);

        DisableControlAction(0, 1, display) -- Mirar izquierda/derecha
        DisableControlAction(0, 2, display) -- Mirar hacia atras
        DisableControlAction(0, 142, display) -- Alternar ataques de melee
        DisableControlAction(0, 18, display) -- Enter
        DisableControlAction(0, 322, display) -- ESC
        DisableControlAction(0, 106, display) -- Control del mouse en vehículos
    end
end)

function SetTablet(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
    })
end

function chat(str, color)
    TriggerEvent("chat:addMessage", {
        color = color,
        multiline = true,
        args = {str}
    })
end

RegisterNUICallback('add-history', function(data, cb)
    ESX.TriggerServerCallback('stahl_policetablet:add-history', function(event)
    cb(event)
  end, data)
end)