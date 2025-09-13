Config = {};

Config.ESX = 'es_extended';

Config.GlobalSound = 'rhino';

Config.AuspuffBlacklist = {
    ['brawler'] = true,
    -- add more
};

Config.Hotkey = {
    aktivieren = true,
    taste = 'Y'
};

Config.AuspuffSounds = {
    ['t20'] = 'schafter3',
    -- add more
};

Config.VIP_AuspuffSounds = {
    ['ABC 123'] = 'fbi',
    -- add more
};

Config.SendNotify = function(color, title, message, time)
    TriggerClientEvent('ws_notify', source, color, title, message, time) -- your notify trigger
end

-- ruthless1337 on github
-- > rth4s @ discord