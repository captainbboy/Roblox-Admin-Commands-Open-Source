-- This is a regular Script file located in ServerScriptService --

local main = require(game.ServerScriptService.AdminCommandSettings)

---------------------
-- Rolox Variables --
---------------------

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

--------------
-- Settings --
--------------

local chatPrefix = main.settings.Main.chatPrefix

local groupId = main.settings.Main.groupId
local moderator = main.settings.Main.moderator
local admin = main.settings.Main.admin
local owner = main.settings.Main.owner

local modUser = main.settings.Main.moderatorUser
local adminUser = main.settings.Main.adminUser
local ownerUser = main.settings.Main.ownerUser

local modPerms = main.settings.Main.modPerms
local adminPerms = main.settings.Main.adminPerms
local ownerPerms = main.settings.Main.ownerPerms

local logEnabled = main.settings.DiscordWebhook.enabled
local logURL = main.settings.DiscordWebhook.URL

------------------------
-- Permission Checker --
------------------------

function hasPermissionToUseCommand(player, command)
	if groupId ~= 0 then
		if player:IsInGroup(groupId) then
			local role = player:GetRankInGroup(groupId)
			if arrayHas(moderator, role) and arrayHas(modPerms, command) then
				return true
			end
			if arrayHas(admin, role) and arrayHas(adminPerms, command) then
				return true
			end
			if arrayHas(owner, role) and arrayHas(ownerPerms, command) then
				return true
			end
		end
	end
	if arrayHas(modUser, player.UserId) and arrayHas(modPerms, command) then
		return true
	end
	if arrayHas(adminUser, player.UserId) and arrayHas(adminPerms, command) then
		return true
	end
	if arrayHas(ownerUser, player.UserId) and arrayHas(ownerPerms, command) then
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

		-- TpTo Command
		if command:lower() == "to" or command:lower() == "tpto" then
			if hasPermissionToUseCommand(player, "TpTo") == true then
				print(player.Name.." has permission to do TpTo!")
				local Target = FindPlayer(args[2])
				if Target == nil then
					print(player.Name.." didn't include a Target!")
					-- notify(player, "You didn't include a Target!")
				else 
					if Target and Target.Character ~= nil and player.Character:FindFirstChild("HumanoidRootPart") ~= nil and player and player.Character ~= nil and player.Character:FindFirstChild("HumanoidRootPart") ~= nil then
						player.Character.HumanoidRootPart.CFrame = CFrame.new(Target.Character.HumanoidRootPart.Position) * CFrame.new(math.random(1,5), 3, math.random(1, 5))
						-- notify(player, "You teleported to "..Target.Name)
						sendLogMessage(player, player.Name.." teleported to **"..Target.Name.."**")
						print(player.Name.." teleported to "..Target.Name)
					end
				end
			end
		end

		--TpBring Command
		if command:lower() == "bring" or command:lower() == "tpbring" or command:lower() == "tptome" then
			if hasPermissionToUseCommand(player, "TpBring") == true then
				print(player.Name.." has permission to do TpBring!")
				local Target = FindPlayer(args[2])
				if Target == nil then
					print(player.Name.." didn't include a Target!")
					-- notify(player, "You didn't include a Target!")
				else 
					if player and player.Character ~= nil and Target.Character:FindFirstChild("HumanoidRootPart") ~= nil and Target and Target.Character ~= nil and Target.Character:FindFirstChild("HumanoidRootPart") ~= nil then
						Target.Character.HumanoidRootPart.CFrame = CFrame.new(player.Character.HumanoidRootPart.Position) * CFrame.new(math.random(1,5), 3, math.random(1, 5))
						-- notify(player, "You have brought "..Target.Name.." to you")
						sendLogMessage(player, player.Name.." brought **"..Target.Name.."** to them")
						print(player.Name.." brought "..Target.Name.." to them")
					end
				end
			end
		end

		--ClearTools
		if command:lower() == "cleartools" or command:lower() == "removetools" or command:lower() == "clrtools" then
			if hasPermissionToUseCommand(player, "ClearTools") == true then
				print(player.Name.." has permission to do ClearTools!")
				local Target = FindPlayer(args[2])
				if Target == nil then
					print(player.Name.." didn't include a Target!")
					-- notify(player, "You didn't include a Target!")
				else 		
					if Target and Target:FindFirstChildOfClass("Backpack") then
						Target:FindFirstChildOfClass("Backpack"):ClearAllChildren()
						for i,v in pairs(Target.Character:GetChildren()) do
							if v:IsA("Tool") then
								v:Destroy()
							end
						end
						sendLogMessage(player, player.Name.." removed all of **"..Target.Name.."**'s tools.")
						print(player.Name.." removed all of "..Target.Name.."'s tools.")
					end
				end
			end
		end

		--Kick
		if command:lower() == "kick" then
			if hasPermissionToUseCommand(player, "Kick") == true then
				print(player.Name.." has permission to do Kick!")
				local Target = FindPlayer(args[2])
				if Target == nil then
					print(player.Name.." didn't include a Target!")
					-- notify(player, "You didn't include a Target!")
				else 		
					table.remove(args, 1)
					table.remove(args, 1)
					local reason = table.concat(args, " ")
					sendLogMessage(player, player.Name.." kicked **"..Target.Name.."** with the reason: '"..reason.."'.")
					print(player.Name.." kicked "..Target.Name.." with the reason: '"..reason.."'.")
					Target:Kick("You have been kicked for: "..reason)
				end
			end
		end

	end
end

local function onPlayerAdded(player)
	player.Chatted:Connect(function (message) onPlayerChatted(player, message) end)
end

game.Players.PlayerAdded:Connect(onPlayerAdded)

---------------------
-- Misc. Functions --
---------------------

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

function sendLogMessage(player, message)
	if logEnabled == true and logURL ~= nil then
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
		print(logURL)
		print(MessageData)
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