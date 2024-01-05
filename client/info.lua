local cash
local bank

local function Toggle(state)

    SendNUIMessage({
        message = 'toggle',
        value = state
    })
    
end

local function UpdateAccounts(accounts)
    if accounts == nil then return end

    local tempCash, tempBank

    for _, data in pairs(accounts) do
        if data.name == 'bank' then
            tempBank = data.money
        elseif data.name == 'money' then
            tempCash = data.money
        end
    end

    return tempCash, tempBank
end


local function MainThread()
    Toggle(true)

    CreateThread(function()

        local playerServerId = GetPlayerServerId(PlayerId())

        while true do


                SendNUIMessage({
                    message = 'info',
                    value = {
                        bank = ("$" .. bank),
                        money = ("$" .. cash),
                        job = string.upper(ESX.PlayerData.job.label),
                        id = string.upper("ID " .. playerServerId),
                        player = GlobalState["OnlinePlayers"],
                        orario = GlobalState["orario"]
                    }
                })
                Wait(1000)
        end
    end)
end


RegisterNetEvent('krs_hud:orario', function()


end)


AddEventHandler('esx:playerLoaded', function(playerData)
    cash, bank = UpdateAccounts(playerData.accounts)
    MainThread()
end)

AddEventHandler('esx:onPlayerLogout', function()
    Toggle(false)
end)

AddEventHandler('esx:pauseMenuActive', function(state)
    Toggle(not state)
end)

RegisterNetEvent('esx:setAccountMoney', function(account)
    if account.name == 'money' then
        cash = account.money
    elseif account.name == 'bank' then
        bank = account.money
    end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

AddEventHandler('onResourceStart', function (resName)
    if GetCurrentResourceName() ~= resName then return end
    Wait(1000)
    ESX.PlayerData = ESX.GetPlayerData()
    cash, bank = UpdateAccounts(ESX.PlayerData.accounts)
    MainThread()
end)