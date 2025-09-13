local ESX = exports[Config.ESX]:getSharedObject()

if Config.Hotkey.aktivieren then
    RegisterCommand('klappenauspuff', function()
        TriggerServerEvent("ruthless:ka:banplayeronID")
    end, false)

    RegisterKeyMapping('klappenauspuff', 'Klappenauspuff öffnen/schließen', 'keyboard', Config.Hotkey.taste:lower())
end

AddStateBagChangeHandler("ruthless:ka", nil, function(bagName, key, value, _, replicated)
    if not replicated then return end
    if not value or type(value) ~= "table" then return end

    local netId = tonumber(bagName:gsub("entity:", ""), 10)
    if not netId then return end

    local entity = NetworkGetEntityFromNetworkId(netId)
    if not DoesEntityExist(entity) or not IsEntityAVehicle(entity) then return end

    if value.state then
        if value.sound then
            ForceVehicleEngineAudio(entity, value.sound)
        end
    else
        ForceVehicleEngineAudio(entity, Config.GlobalSound)
    end
end)

-- ruthless1337 on github
-- > rth4s @ discord