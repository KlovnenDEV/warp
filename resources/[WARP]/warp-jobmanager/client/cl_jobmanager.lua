
RegisterNetEvent("warp-jobmanager:playerBecameJob")
AddEventHandler("warp-jobmanager:playerBecameJob", function(job, name, notify)
    local LocalPlayer = exports["warp-base"]:getModule("LocalPlayer")
    LocalPlayer:setVar("job", job)
    if notify ~= false then TriggerEvent("DoLongHudText", job ~= "unemployed" and "New Job: " .. tostring(name) or "You're now unemployed", 1) end
    if name == "Entertainer" then
	    TriggerEvent('DoLongHudText',"College DJ and Comedy Club pay per person around you",1)
	end
    if name == "Broadcaster" then
        TriggerEvent('DoLongHudText',"(RadioButton + LeftCtrl for radio toggle)",3)
        TriggerEvent('DoLongHudText',"Broadcast from this room and give out the vibes to los santos on 1982.9",1)
    end  
	if job == "unemployed"  then
		SetPedRelationshipGroupDefaultHash(PlayerPedId(),`PLAYER`)
        SetPoliceIgnorePlayer(PlayerPedId(),false)
        TriggerEvent("ResetRadioChannel");
	end
    
    if job == "trucker" then
        TriggerServerEvent("TokoVoip:addPlayerToRadio", 4, GetPlayerServerId(PlayerId()))
    end

    if job == "towtruck" then
        TriggerEvent("DoLongHudText","Use /tow to tow cars to your truck.",1)
        TriggerServerEvent("TokoVoip:addPlayerToRadio", 3, GetPlayerServerId(PlayerId()))
    end

    if job == "driving instructor"  then
        TriggerEvent('DoLongHudText',"'/driving' to use access driving instructor systems",1)
    end
end)

RegisterNetEvent("warp-base:characterLoaded")
AddEventHandler("warp-base:characterLoaded", function(character)
    local LocalPlayer = exports["warp-base"]:getModule("LocalPlayer")
    LocalPlayer:setVar("job", "unemployed")

end)

RegisterNetEvent("warp-base:exportsReady")
AddEventHandler("warp-base:exportsReady", function()
    exports["warp-base"]:addModule("JobManager", Void.Jobs)
end)

RegisterNetEvent('dreams-collect:paycheck')
AddEventHandler('dreams-collect:paycheck', function()
    TriggerServerEvent("paycheck:collect", exports["isPed"]:isPed("cid"))
end)