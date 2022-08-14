-- Copyright 2022 © aymanTV (AN Services)
-- Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
-- The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

----- Made By https://aymantv.tebex.io/
----- For Support, Join my Discord: https://discord.gg/f2Nbv9Ebf5
----- For custom services or help, check my Fiverr: https://www.fiverr.com/aymannajim

local PlayerData
local PlayerJob
local PlayerJob2

local createdBlips = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
		
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
		
	PlayerData = ESX.GetPlayerData()
	PlayerJob = PlayerData.job
	PlayerJob2 = PlayerData.job2
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
	PlayerJob = PlayerData.job
	PlayerJob2 = PlayerData.job2
	Wait(2000)
	loadBlips()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	PlayerJob = job
	for k,v in pairs(createdBlips) do
		RemoveBlip(v)
	end
	Wait(500)
	loadBlips()
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
	PlayerData.job2 = job2
	PlayerJob2 = job2
	for k,v in pairs(createdBlips) do
		RemoveBlip(v)
	end
	Wait(500)
	loadBlips()
end)



function loadBlips()
	for k,v in pairs(Config.Blips) do
		local canSee = false
		if #v.AllowedJobs == 0 then
			canSee = true
		elseif #v.DeniedJobs == 0 then
			canSee = false
		end
		for key,val in pairs(v.AllowedJobs) do
			if getJob() == val or val == getJob2() == val then
				canSee = true
			end
		end
		for ke,va in pairs(v.DeniedJobs) do
			if va == getJob() or va == getJob2() then
				canSee = false
			end
		end
		if canSee then
			local blip = AddBlipForCoord(v.Coords.x, v.Coords.y, v.Coords.z)
			SetBlipSprite(blip, v.Blip.sprite)
			SetBlipDisplay(blip, 4)
			SetBlipScale(blip, v.Blip.size)
			SetBlipColour(blip, v.Blip.color)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(v.Blip.name)
			EndTextCommandSetBlipName(blip)
			table.insert(createdBlips, blip)
		end
	end
end

function getJob()
	PlayerJob = PlayerData.job
	return PlayerJob.name
end

function getJob2()
	PlayerJob2 = PlayerData.job2
	return PlayerJob2.name
end

----- Made By https://aymantv.tebex.io/
----- For Support, Join my Discord: https://discord.gg/f2Nbv9Ebf5
----- For custom services or help, check my Fiverr: https://www.fiverr.com/aymannajim
