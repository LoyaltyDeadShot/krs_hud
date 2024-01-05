RegisterCommand('_hudsettings', function()
    if not IsPauseMenuActive() then
        local options = {
            {
                type = 'checkbox',
                label = 'Round Map',
                value = buildRoundedMap
            },
            {
                type = 'checkbox',
                label = 'Rectangular Map',
                value = buildSquaredMap
            }
        }
        
        local input = lib.inputDialog('Krs Hud Settings', options)

        if not input then return end

        if input[1] == true then
            buildRoundedMap()
        end

        if input[2] == true then
            buildSquaredMap()
        end
    end
end, false)



RegisterNetEvent('esx:playerLoaded', function()
    buildSquaredMap()
    buildRoundedMap()
end)

function buildSquaredMap()
    RequestStreamedTextureDict("squaremap", false)
    if not HasStreamedTextureDictLoaded("squaremap") then
        Wait(150)
    end
    SetMinimapClipType(0)
    AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "squaremap", "radarmasksm")
    AddReplaceTexture("platform:/textures/graphics", "radarmask1g", "squaremap", "radarmasksm")

    SetMinimapComponentPosition("minimap", "L", "B", -0.175, -0.067, 0.1638, 0.183)  
    SetMinimapComponentPosition("minimap_mask", "L", "B", 0.005, -0.06, 0.128, 0.20)  
    SetMinimapComponentPosition('minimap_blur', 'L', 'B', -0.175, -0.032, 0.270, 0.300)  
    
    SetMinimapComponentPosition("minimap", "L", "B", -0.175, -0.067, 0.1638, 0.183)  
    SetMinimapComponentPosition("minimap_mask", "L", "B", 0.005, -0.06, 0.128, 0.20)  
    SetMinimapComponentPosition('minimap_blur', 'L', 'B', -0.175, -0.032, 0.270, 0.300)  
    
    SetMinimapComponentPosition("minimap", "L", "B", -0.010, -0.067, 0.1638, 0.183)  
    SetMinimapComponentPosition("minimap_mask", "L", "B", 0.015, -0.06, 0.128, 0.20)  
    SetMinimapComponentPosition('minimap_blur', 'L', 'B', -0.010, statusbartype == "old" and -0.077 or -0.032, 0.262, 0.300)  
    
    SetBlipAlpha(GetNorthRadarBlip(), 0)
    SetRadarBigmapEnabled(true, false)
    SetMinimapClipType(0)
    Wait(50)
    SetRadarBigmapEnabled(false, false)
    Wait(1200)
end

function buildRoundedMap()
    local x = -0.025
    local y = -0.015
    local w = 0.16
    local h = 0.20

    RequestStreamedTextureDict("circlemap", false)
    if not HasStreamedTextureDictLoaded("circlemap") then
        Wait(150)
    end

    SetMinimapClipType(1)
    AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "circlemap", "radarmasksm")

    SetMinimapComponentPosition('minimap', 'L', 'B', -0.170, 0.02, w, h)  
    SetMinimapComponentPosition('minimap_mask', 'L', 'B', x + 0.18, y + 0.14, 0.072, 0.162)  
    SetMinimapComponentPosition('minimap_blur', 'L', 'B', -0.185, -0.03, 0.18, 0.22)  

    SetMinimapComponentPosition('minimap', 'L', 'B', -0.170, -0.005, w, h)  
    SetMinimapComponentPosition('minimap_mask', 'L', 'B', x + 0.18, y + 0.09, 0.072, 0.162)  
    SetMinimapComponentPosition('minimap_blur', 'L', 'B', -0.185, -0.005, 0.18, 0.22)  

    SetMinimapComponentPosition('minimap', 'L', 'B', -0.010, y - 0.02, w, h)  
    SetMinimapComponentPosition('minimap_mask', 'L', 'B', x + 0.17, y + 0.01, 0.072, 0.162)  
    SetMinimapComponentPosition('minimap_blur', 'L', 'B', -0.020, -0.06, 0.18, 0.20)  

    SetBlipAlpha(GetNorthRadarBlip(), 0)
    SetMinimapClipType(1)
    SetRadarBigmapEnabled(true, false)
    Wait(50)
    SetRadarBigmapEnabled(false, false)
end

Wait(2500)

if IsBigmapActive() then
    SetRadarBigmapEnabled(false, false)
    SetBigmapActive(false, false)
end
