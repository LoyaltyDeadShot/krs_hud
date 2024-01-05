function UpdatePlayerCount()
    GlobalState["OnlinePlayers"] = onlineplayers
end

RegisterNetEvent('esx:playerLoaded', function()
    onlineplayers +=1
    UpdatePlayerCount()
end)

RegisterNetEvent('esx:playerDropped', function()
    onlineplayers -=1
    if onlineplayers <0 then onlineplayers =0 end
    UpdatePlayerCount()
end)

AddEventHandler("onResourceStart", function(resourceName)
    local currentName = GetCurrentResourceName()
    if resourceName ~= currentName then
        return
    end
    onlineplayers  = #GetPlayers()
    UpdatePlayerCount()
end)


CreateThread(function()

    while true do

        orario = os.date("%H:%M")

        GlobalState["orario"] = orario
        Wait(5000)
    end
end)


lib.versionCheck('Krs-Scripts/krs_hud')