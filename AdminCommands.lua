-- This is a regular Script file located in ServerScriptService --

local main = require(game.ServerScriptService.AdminCommandSettings)

---------------------
-- Rolox Variables --
---------------------

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local DataStoreService = game:GetService("DataStoreService")

--------------
-- Settings --
--------------

local devMode = true -- Displays Print Messages

local chatPrefix = main.settings.Main.chatPrefix

local groupId = main.settings.Main.groupId
local moderator = main.settings.Main.moderator
local admin = main.settings.Main.admin
local manager = main.settings.Main.manager
local owner = main.settings.Main.owner

local modUser = main.settings.Main.moderatorUser
local adminUser = main.settings.Main.adminUser
local managerUser = main.settings.Main.managerUser
local ownerUser = main.settings.Main.ownerUser

local modPerms = main.settings.Main.modPerms
local adminPerms = main.settings.Main.adminPerms
local managerPerms = main.settings.Main.managerPerms
local ownerPerms = main.settings.Main.ownerPerms

local logEnabled = main.settings.DiscordWebhook.enabled
local logURL = main.settings.DiscordWebhook.URL

---------------
-- Databases --
---------------

local bansTable = {}
local banStore = DataStoreService:GetDataStore("Bans")

------------------------
-- Permission Checker --
------------------------

function hasPermissionToUseCommand(player, command)
	if groupId ~= 0 then
		if player:IsInGroup(groupId) then
			local role = player:GetRankInGroup(groupId)
			if arrayHas(moderator, role) and arrayHas(modPerms, command) then
				if devMode then 
					print(player.Name.." has permission to do "..command.."!")
				end
				return true
			end
			if arrayHas(admin, role) and arrayHas(adminPerms, command) then
				if devMode then 
					print(player.Name.." has permission to do "..command.."!")
				end
				return true
			end
			if arrayHas(manager, role) and arrayHas(managerPerms, command) then
				if devMode then 
					print(player.Name.." has permission to do "..command.."!")
				end
				return true
			end
			if arrayHas(owner, role) and arrayHas(ownerPerms, command) then
				if devMode then 
					print(player.Name.." has permission to do "..command.."!")
				end
				return true
			end
		end
	end
	if arrayHas(modUser, player.UserId) and arrayHas(modPerms, command) then
		if devMode then 
			print(player.Name.." has permission to do "..command.."!")
		end
		return true
	end
	if arrayHas(adminUser, player.UserId) and arrayHas(adminPerms, command) then
		if devMode then 
			print(player.Name.." has permission to do "..command.."!")
		end
		return true
	end
	if arrayHas(managerUser, player.UserId) and arrayHas(managerPerms, command) then
		if devMode then 
			print(player.Name.." has permission to do "..command.."!")
		end
		return true
	end
	if arrayHas(ownerUser, player.UserId) and arrayHas(ownerPerms, command) then
		if devMode then 
			print(player.Name.." has permission to do "..command.."!")
		end
		return true
	end
	return false;
end

--------------------------
-- Chat Command Handler --
--------------------------

local function onPlayerChatted(player, message)
	if startsWith(message, chatPrefix) == true then
		message = message:sub(chatPrefix:len()+1)
		local args = splitMessage(message)
		local command = args[1]

		if command == nil then
			return;
		end
		
		-- Base Command:
		local cmd = "TESTING"
		if isCommand(command, cmd) then
			if hasPermissionToUseCommand(player, cmd) == true then
				if(checkParameters(player, args, cmd)) then
					
				end
			end
		end
		
		-- TpTo Command
		local cmd = "TpTo"
		if isCommand(command, cmd) then
			if hasPermissionToUseCommand(player, cmd) == true then
				if(checkParameters(player, args, cmd)) then
					local Target = FindPlayer(args[2])
					if Target == nil then
						if devMode then
							print(player.Name.." didn't include a Target!")
						end
						-- notify(player, "You didn't include a Target!")
					else 
						if Target and Target.Character ~= nil and player.Character:FindFirstChild("HumanoidRootPart") ~= nil and player and player.Character ~= nil and player.Character:FindFirstChild("HumanoidRootPart") ~= nil then
							player.Character.HumanoidRootPart.CFrame = CFrame.new(Target.Character.HumanoidRootPart.Position) * CFrame.new(math.random(1,5), 3, math.random(1, 5))
							-- notify(player, "You teleported to "..Target.Name)
							sendLogMessage(player, player.Name.." teleported to **"..Target.Name.."**", cmd)
						end
					end
				end
			end
		end

		--TpBring Command
		local cmd = "TpBring"
		if isCommand(command, cmd) then
			if hasPermissionToUseCommand(player, "TpBring") == true then
				local Target = FindPlayer(args[2])
				if Target == nil then
					if devMode then 
						print(player.Name.." didn't include a Target!")
					end					
					-- notify(player, "You didn't include a Target!")
				else 
					if player and player.Character ~= nil and Target.Character:FindFirstChild("HumanoidRootPart") ~= nil and Target and Target.Character ~= nil and Target.Character:FindFirstChild("HumanoidRootPart") ~= nil then
						Target.Character.HumanoidRootPart.CFrame = CFrame.new(player.Character.HumanoidRootPart.Position) * CFrame.new(math.random(1,5), 3, math.random(1, 5))
						-- notify(player, "You have brought "..Target.Name.." to you")
						sendLogMessage(player, player.Name.." brought **"..Target.Name.."** to them", cmd)
					end
				end
			end
		end

		--ClearTools
		local cmd = "ClearTools"
		if isCommand(command, cmd) then
			if hasPermissionToUseCommand(player, cmd) == true then
				if(checkParameters(player, args, cmd)) then
					local Target = FindPlayer(args[2])
					if Target == nil then
						if devMode then 
							print(player.Name.." didn't include a Target!")
						end
						-- notify(player, "You didn't include a Target!")
					else 		
						if Target and Target:FindFirstChildOfClass("Backpack") then
							Target:FindFirstChildOfClass("Backpack"):ClearAllChildren()
							for i,v in pairs(Target.Character:GetChildren()) do
								if v:IsA("Tool") then
									v:Destroy()
								end
							end
							sendLogMessage(player, player.Name.." removed all of **"..Target.Name.."**'s tools.", cmd)
						end
					end
				end
			end
		end

		--Kick
		local cmd = "Kick"
		if isCommand(command, cmd) then
			if hasPermissionToUseCommand(player, cmd) == true then
				if(checkParameters(player, args, cmd)) then
					local Target = FindPlayer(args[2])
					if Target == nil then
						if devMode then 
							print(player.Name.." didn't include a Target!")
						end						
						-- notify(player, "You didn't include a Target!")
					else 		
						table.remove(args, 1)
						table.remove(args, 1)
						local reason = table.concat(args, " ")
						if reason == nil or reason == "" then
							reason = "Not provided"
						end
						sendLogMessage(player, player.Name.." kicked **"..Target.Name.."** with the reason: '"..reason.."'.", cmd)
						Target:Kick("You have been kicked for: "..reason)
					end
				end
			end
		end
		
		--Ban
		local cmd = "Ban"
		if isCommand(command, cmd) then
			if hasPermissionToUseCommand(player, cmd) == true then
				if(checkParameters(player, args, cmd)) then
					local Target = FindPlayer(args[2])
					if Target == nil then
						if devMode then 
							print(player.Name.." didn't include a Target!")
						end						
						-- notify(player, "You didn't include a Target!")
					else
						table.insert(bansTable, Target.UserId)
						table.remove(args, 1)
						table.remove(args, 1)
						local reason = table.concat(args, " ")
						if reason == nil or reason == "" then
							reason = "Not provided"
						end
						sendLogMessage(player, player.Name.." banned **"..Target.Name.."** with the reason: '"..reason.."'.", cmd)
						Target:Kick("You have been banned for: "..reason)
					end
				end
			end
		end
		
		--PermBan
		local cmd = "PermBan"
		if isCommand(command, cmd) then
			if hasPermissionToUseCommand(player, cmd) == true then
				if(checkParameters(player, args, cmd)) then
					local Target = FindPlayer(args[2])
					if Target == nil then
						local userid = getUserIdFromUsername(args[2])
						if userid then
							Target = {
								["Name"] = args[2],
								["UserId"] = userid,
								["isFAKE"] = true;
							}							
						end
					end
					if Target == nil then
						if devMode then 
							print(player.Name.." didn't include a Target!")
						end						
						-- notify(player, "You didn't include a Target!")
					else						
						table.remove(args, 1)
						table.remove(args, 1)
						local reason = table.concat(args, " ")
						if reason == nil or reason == "" then
							reason = "Not provided"
						end
						
						local banTable = {
							["isPerm"] = true,
							["reason"] = reason
						}

						local success, err = pcall(function()
							banStore:SetAsync(Target.UserId, banTable)
						end)

						if success then
							sendLogMessage(player, player.Name.." permanently banned **"..Target.Name.." ("..Target.UserId..")** with the reason: '"..reason.."'.", cmd)
							if Target.isFAKE ~= true then
								Target:Kick("You have been permanently banned for: '"..reason.."'")
							end
						else 
							print("ERROR saving to bansStore!")
							warn(err)
						end
					end
				end
			end
		end
		
		--UnBan
		local cmd = "UnBan"
		if isCommand(command, cmd) then
			if hasPermissionToUseCommand(player, cmd) == true then
				if(checkParameters(player, args, cmd)) then
					local UserID = getUserIdFromUsername(args[2])
					if UserID == nil then
						if devMode then 
							print(player.Name.." gave an invalid username!")
						end						
						-- notify(player, "You gave an invalid username!")
					else
						if arrayHas(bansTable, UserID) then
							table.remove(bansTable, UserID)
						end
						
						local banInfo
						local success, err = pcall(function()
							banInfo = banStore:GetAsync(UserID)
						end)

						if success then
							if banInfo ~= nil then
								local success2, err2 = pcall(function()
									banInfo = banStore:RemoveAsync(UserID)
								end)

								if success2 then
									sendLogMessage(player, player.Name.." unbanned **"..args[2].."**.", cmd)
									-- notify(player, "You have successfully unbanned "..args[2]..".")
								else
									print("ERROR removing from bansStore!")
									warn(err2)
								end
							else 
								if devMode then 
									print(args[2].." isn't banned!")
								end						
								-- notify(player, args[2].." isn't banned!")
							end
						else 
							print("ERROR retrieving from bansStore!")
							warn(err)
						end
						
					end
				end
			end
		end
		
	end
end

local function onPlayerAdded(player)
	
	handleIfBanned(player)
	
	player.Chatted:Connect(function (message) onPlayerChatted(player, message) end)
	
end

game.Players.PlayerAdded:Connect(onPlayerAdded)

---------------------
-- Misc. Functions --
---------------------

local usernameCache = {}
function getUserIdFromUsername(name)
	-- First, check if the cache contains the name
	if usernameCache[name] then return usernameCache[name] end
	-- Second, check if the user is already connected to the server
	local player = Players:FindFirstChild(name)
	if player then
		usernameCache[name] = player.UserId
		return player.UserId
	end 
	-- If all else fails, send a request
	local id
	pcall(function ()
		id = Players:GetUserIdFromNameAsync(name)
	end)
	usernameCache[name] = id
	return id
end

function handleIfBanned(player)
	
	--if(player.Name == "captain_bboy") then
	--	local success, banInfo = pcall(function()
	--		return banStore:RemoveAsync(player.UserId)
	--	end)
	--end
	
	if arrayHas(bansTable, player.UserId) then
		player:Kick("You are banned from this game.")
		return;
	end
	
	local success, banInfo = pcall(function()
		return banStore:GetAsync(player.UserId)
	end)

	if success then
		if banInfo ~= nil then
			if banInfo.isPerm == true then
				if banInfo.reason ~= nil and banInfo.reason ~= "" then
					player:Kick("You are permanently banned from this game for '"..banInfo.reason.."'.")
				else
					player:Kick("You are permanently banned from this game.")
				end
			else
				if banInfo.expiredTime ~= nil and banInfo.expiredTime > os.time() then
					if banInfo.reason ~= nil and banInfo.reason ~= "" then
						player:Kick("You are permanently banned from this game for '"..banInfo.reason.."'.")
					else
						player:Kick("You are permanently banned from this game.")
					end
				end
			end
		end
	end
end 

function isCommand(message, command)
	if main.commands[command] and (main.commands[command].command:lower() == message:lower() or arrayHasLower(main.commands[command].aliases, message:lower())) then
		return true
	end
	
	return false
end

function checkParameters(player, args, cmd)
	if((table.getn(args) - 1) < table.getn(main.commands[cmd].parameters)) then
		if devMode then 
			print(player.Name.." didn't didn't include the correct parameters! Required parameters: "..table.concat(main.commands[cmd].parameters, ", "))
		end
		-- notify(player, "You didn't include the correct parameters! Required parameters: "..table.concat(main.commands[cmd].parameters, ", "))
		return false
	end
	
	return true
end

function FindPlayer(Name)
	for i, Player in pairs(Players:GetPlayers()) do
		if startsWith(Player.Name:lower(), Name:lower()) then
			return Player
		end
	end

	return nil
end

-- Fetch the thumbnail
function getThumbnailURL(player)
	local userId = player.UserId
	local thumbType = Enum.ThumbnailType.HeadShot
	local thumbSize = Enum.ThumbnailSize.Size420x420
	local content, isReady = Players:GetUserThumbnailAsync(userId, thumbType, thumbSize)
	return content
end

function sendLogMessage(player, message, cmd)
	if devMode then
		local msg = message:gsub("*", "")
		print(msg)
	end
	if logEnabled == true and logURL ~= nil and main.commands[cmd] and main.commands[cmd].log then
		local MessageData = {
			["embeds"] = {{
				["title"] = "Moderation Logs",
				["description"] = message,
				["color"] = tonumber(0xffffff),
				["thumbnail"] = {
					["url"] = "https://www.roblox.com/Thumbs/Avatar.ashx?x=100&y=100&username="..player.Name,
				},
				["footer"] = {
					["text"] = "Provided by OpenSource Admin Commands by captain_bboy"
				}
			}},
		}		
		MessageData = HttpService:JSONEncode(MessageData)
		--print(logURL)
		--print(MessageData)
		HttpService:PostAsync(logURL, MessageData)
	end
end

function sendChatMessage(message)
	game.StarterGui:SetCore("ChatMakeSystemMessage", {
		Text = message,
		Color = Color3.fromRGB(255,165,0),
		Font = Enum.Font.SourceSansBold
	})
end

function splitMessage (inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={}
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		table.insert(t, str)
	end
	return t
end

function startsWith(String,Start)
	return string.sub(String,1,string.len(Start))==Start
end

function arrayHas (tab, val)
	for index, value in ipairs(tab) do
		if value == val then
			return true
		end
	end

	return false
end

function arrayHasLower (tab, val)
	for index, value in ipairs(tab) do
		if value:lower() == val:lower() then
			return true
		end
	end

	return false
end