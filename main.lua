blip = nil

function initializeBlip()
    local blipName = "Smog"
    local blipCoords = landmarks[blipName]
    blip = AddBlipForCoord(blipCoords.x, blipCoords.y, blipCoords.z)
    SetBlipScale(blip, 1.0)
    SetBlipSprite(blip, 132)
    SetBlipColour(blip, 1)
    SetBlipAlpha(blip, 255)
    AddTextEntry("SMOG", "The Smog")
    BeginTextCommandSetBlipName("SMOG")
    EndTextCommandSetBlip(blip)
    SetBlipCategory(blip, 2)
    print("blip id: " .. blip)
end

Citizen.CreateThread(initializeBlip)

RegisterCommand(
    "removeblip",
    function(source,args)
        if DoesBlipExist(blip) then
            TriggerServerEvent("blips:takeBlip")
        end
    end
)

RegisterCommand("bliptome", function(source, args) 
    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
    TriggerServerEvent("blips:takeBlip", x, y, z)
end)

RegisterNetEvent("blips:setBlip", function(x, y, z) 
    if DoesBlipExist(blip) and x ~= nil then
        SetBlipCoords(blip, x, y, z)
        SetBlipAsShortRange(blip, true)
        SetBlipHiddenOnLegend(blip, true)
    else
        RemoveBlip(blip)
        blip = nil
    end
end)