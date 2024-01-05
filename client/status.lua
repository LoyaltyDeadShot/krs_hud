CreateThread(function()
    while true do
        Wait(100)
        local playerPed = cache.ped 

        if IsPedShooting(playerPed) then
            TriggerEvent('esx_status:getStatus', 'stress', function(status)
                local stress = status.val
                local stress2 = stress + 25000
                TriggerEvent('esx_status:set', 'stress', stress2)
            end)
        end
    end
end)

local hunger = 0
local thirst = 0
local stress = 0
local nuotando = false

AddEventHandler('esx_status:onTick', function(status)
    local playerPed = cache.ped 

    for i = 1, #status do
        if status[i].name == 'hunger' then
            hunger = status[i].val / 10000
        elseif status[i].name == 'thirst' then
            thirst = status[i].val / 10000
        elseif status[i].name == 'stress' then
            stress = status[i].val / 10000
        end
    end

    nuotando = IsPedSwimming(playerPed)

    SendNUIMessage({
        message = 'update_hud',
        health = GetEntityHealth(playerPed) - 100,
        hunger = math.floor(hunger),
        thirst = math.floor(thirst),
        stress = stress,
        armour = GetPedArmour(playerPed),
        stamina = GetPlayerStamina(PlayerId()),
        oxygen = GetPlayerUnderwaterTimeRemaining(PlayerId()) * 10,
        voice = NetworkIsPlayerTalking(PlayerId()),
        attiva = nuotando,
    })
end)