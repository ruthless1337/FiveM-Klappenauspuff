local ESX = exports[Config.ESX]:getSharedObject()

local vehicles = {}
local cachedSounds = {}

local notify = {
    opened = {
        color = "success",
        title = "Klappenauspuff",
        message = "geöffnet",
        time = 6000
    },
    closed = {
        color = "error",
        title = "Klappenauspuff",
        message = "geschlossen",
        time = 6000
    },
    blacklisted = {
        color = "error",
        title = "Klappenauspuff",
        message = "Das Fahrzeug ist geblacklisted!",
        time = 6000
    }
}

RegisterNetEvent("ruthless:ka:banplayeronID", function()
    local src = source
    Togglerp1au55puff(src)
end)

function Togglerp1au55puff(playerId)
    local ped = GetPlayerPed(playerId)
    local vehicle = GetVehiclePedIsIn(ped, false)

    if ped and vehicle ~= 0 then
        local plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))
        vehicles[plate] = vehicles[plate] or {}

        local vehicleData = vehicles[plate]
        local isBlacklisted = false

        if vehicleData.state then
            vehicleData.state = false
            Config.SendNotify(notify.closed.color, notify.closed.title, notify.closed.message, notify.closed.time)
        else
            local model = GetEntityModel(vehicle)

            for modelName, _ in pairs(Config.AuspuffBlacklist) do
                if GetHashKey(modelName) == model then
                    isBlacklisted = true
                    Config.SendNotify(notify.blacklisted.color, notify.blacklisted.title, notify.blacklisted.message, notify.blacklisted.time)
                    break
                end
            end

            if not isBlacklisted then
                if Config.VIP_AuspuffSounds[plate] then
                    vehicleData.sound = Config.VIP_AuspuffSounds[plate]
                else
                    if cachedSounds[model] then
                        vehicleData.sound = cachedSounds[model]
                    else
                        for modelName, sound in pairs(Config.AuspuffSounds) do
                            if GetHashKey(modelName) == model then
                                vehicleData.sound = sound
                                cachedSounds[model] = sound
                                break
                            end
                        end
                    end
                end

                if not vehicleData.sound then
                    vehicleData.sound = Config.GlobalSound
                end

                vehicleData.state = true
                Config.SendNotify(notify.opened.color, notify.opened.title, notify.opened.message, notify.opened.time)
            end
        end

        if not isBlacklisted then
            Entity(vehicle).state:set("ruthless:ka", vehicleData, true)
        end
    end
end

-- ruthless1337 on github
-- > rth4s @ discord