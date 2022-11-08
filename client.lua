QBCore = exports['qb-core']:GetCoreObject()

local PlayerData = {}
local currentwalkingstyle = 'default'
local currentgender = nil

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function(playerData)
	PlayerData = QBCore.Functions.GetPlayerData()
	TriggerServerEvent('qb-walkstyles:server:walkstyles', 'get')
end)

RegisterNetEvent('qb-walkstyles:openmenu', function()
	OpenWalkMenu()
end)
-- // Walkstyle Events \\ --

RegisterCommand('walking-style', function()
  OpenWalkMenu()
end)

RegisterCommand('fetch-style', function()
	TriggerServerEvent('qb-walkstyles:server:walkstyles', 'get')
end)

function OpenWalkMenu()
	local MenuOptions = {
		{
			header = "Walking Styles",
			txt = "Set your walking style here",
			isMenuHeader = true
		},
	}
	for k, v in pairs(Config.Styles) do

		MenuOptions[#MenuOptions+1] = {
			header = "Male Styles",
			txt = "",
			params = {
				event = "qb-walkstyles:opensubstyles",
				args = "male",
			}
		}

		MenuOptions[#MenuOptions+1] = {
			header = "Female Styles",
			txt = "",
			params = {
				event = "qb-walkstyles:opensubstyles",
				args = "female",
			}
		}		
			
		MenuOptions[#MenuOptions+1] = {
			header = "Reset Style (Default)",
			txt = "",
			params = {
				event = "qb-walkstyles:setwalkstyle",
				args = "default",
			}
		}	
	end

	MenuOptions[#MenuOptions+1] = {
        header = "❌ Close",
        txt = "",
        params = {
            event = "qb-menu:closeMenu"
        }
	}
	exports['qb-menu']:openMenu(MenuOptions)
end

RegisterNetEvent('qb-walkstyles:opensubstyles', function(gender)
	currentgender = gender
	local genderName = nil

	if gender == "male" then
		genderName = "Male"
	else
		genderName = "Female"
	end

	local MenuOptions = {
		{
			header = genderName.." Styles",
			txt = "Select your style below",
			isMenuHeader = true
		},
	}	
	local genderType = nil

	if gender == "male" then
		genderConfig = Config.MaleStyles
	else
		genderConfig = Config.FemaleStyles
	end

	for k, v in ipairs(genderConfig) do
		MenuOptions[#MenuOptions+1] = {
			header = v.label,
			txt = "",
			params = {
				event = "qb-walkstyles:setwalkstyle",
				args = {
					anim = v.value,
					label = v.label
				}
			}
		}
	end

	MenuOptions[#MenuOptions+1] = {
		txt = "", 
		header = "⬅️ Return", 
		params = { 
			event = "qb-walkstyles:openmenu" 
		}
	}
	exports['qb-menu']:openMenu(MenuOptions)	
end)

RegisterNetEvent('qb-walkstyles:setwalkstyle', function(details)
	currentwalkingstyle = details.anim
	setwalkstyle(currentwalkingstyle)
	TriggerServerEvent('qb-walkstyles:server:walkstyles', 'update', currentwalkingstyle)
	if currentwalkingstyle ~= "default" then
		TriggerEvent("qb-walkstyles:opensubstyles",currentgender)
	end
	QBCore.Functions.Notify("Your walking style is set to " .. details.label, "error")
end)

function setwalkstyle(anim)
	local playerped = PlayerPedId()

	if anim == 'default' then
		ResetPedMovementClipset(playerped)
		ResetPedWeaponMovementClipset(playerped)
		ResetPedStrafeClipset(playerped)
	else
		RequestAnimSet(anim)
		while not HasAnimSetLoaded(anim) do Citizen.Wait(0) end
		SetPedMovementClipset(playerped, anim)
		ResetPedWeaponMovementClipset(playerped)
		ResetPedStrafeClipset(playerped)
	end
end

RegisterNetEvent('qb-walkstyles:client:walkstyles', function(walkstyle)
	setwalkstyle(walkstyle)
	currentwalkingstyle = walkstyle
end)
