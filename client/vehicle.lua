local cintura = false

local function ShowSpeedometer(isMetric, speed, rpm, gear, fuel, nos)

    SendNUIMessage({
        action = "show",
        isMetric = isMetric,
        speed = speed,
        rpm = rpm,
        gear = gear,
        fuel = fuel,
        nos = nos,
        cintura = cintura
    })

end

local function HideSpeedometer()

    SendNUIMessage({
        action = "hide"
    })

end

Citizen.CreateThread(function()
    while true do
      
        local playerPed = cache.ped
        local vehicle = cache.vehicle

        if vehicle ~= 0 and GetIsVehicleEngineRunning(vehicle) then
            Wait(200)
            local speed = GetEntitySpeed(vehicle)
            local rpm = GetVehicleCurrentRpm(vehicle)
            local gear = GetVehicleCurrentGear(vehicle)
            local fuel = GetVehicleFuelLevel(vehicle)

            ShowSpeedometer(ShouldUseMetricMeasurements(), speed, rpm, gear, fuel, nos)
        else
            HideSpeedometer()
            Wait(1000)
        end
    end
end)


local function UpdateBelt()
        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(2)
                if cintura then
                DisableControlAction(0, 75, true)
            end
        end 
    end)
end

local keybind = lib.addKeybind({
    name = 'cintura',
    description = 'Press K to activate belt',
    defaultKey = 'K',
    onPressed = function()
        local playerPed = cache.ped
        local vehicle = GetVehiclePedIsIn(playerPed, false)

        if IsPedInAnyVehicle(playerPed, true) then

            if GetVehicleClass(vehicle) ~= 8
                and GetVehicleClass(vehicle) ~= 13
                and GetVehicleClass(vehicle) ~= 14
                and GetVehicleClass(vehicle) ~= 15
                and GetVehicleClass(vehicle) ~= 16 then

                cintura = not cintura

                if cintura then
                    UpdateBelt()
                    playSound('buckle', 0.9)
                    lib.notify({
                        id = 'some_identifier',
                        title = 'Notifica Cintura',
                        description = 'Cintura Abilitata',
                        position = 'bottom',
                        style = {
                            backgroundColor = '#141517',
                            color = '#C1C2C5',
                            ['.description'] = {
                            color = '#909296'
                            }
                        },
                        icon = 'fas fa-compress-alt',
                        iconColor = '#0CA678'
                    })
                elseif not cintura then
                    playSound('unbuckle', 0.9)
                    SetFlyThroughWindscreenParams(16.0, 19.0, 17.0, 2000.0)
                    lib.notify({
                        id = 'some_identifier',
                        title = 'Notifica Cintura',
                        description = 'Cintura Disabilitata',
                        position = 'bottom',
                        style = {
                            backgroundColor = '#141517',
                            color = '#C1C2C5',
                            ['.description'] = {
                            color = '#909296'
                            }
                        },
                        icon = 'fas fa-compress-alt',
                        iconColor = '#F03E3E'
                    })
                end
            end
        end
    end,
})


function playSound(f, v)

    SendNUIMessage({
        type = 'playSound',
        file = f,
        volume = v
    })

end

CreateThread(function()
    while true do
		Wait(2000)
        local playerPed = cache.ped
		if IsPedOnFoot(playerPed) then
			SetRadarZoom(1200) 
		elseif IsPedInAnyVehicle(playerPed, true) then
			SetRadarZoom(1200)
		end
    end
end)