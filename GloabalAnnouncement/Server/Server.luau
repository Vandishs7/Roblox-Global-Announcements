local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MessagingService = game:GetService("MessagingService")

local Whitelist = require(ReplicatedStorage.Modules:WaitForChild("Whitelisted"))
local GlobalRemote = ReplicatedStorage.remotes:WaitForChild("glblanc")

local function sendGlobalMessage(message)
	pcall(function()
		MessagingService:PublishAsync("GlobalAnnounceChannel", message)
	end)
end

Players.PlayerAdded:Connect(function(player)
	player.Chatted:Connect(function(msg)
		if Whitelist:IsWhitelisted(player.UserId) then
			local command, message = msg:match("^!(%w+)%s*(.*)")
			if command and command:lower() == "globalanc" then
				GlobalRemote:FireAllClients({ text = message })
				sendGlobalMessage(message)
			end
		end
	end)
end)

local function onMessageReceived(message)
	if message and message.Data then
		GlobalRemote:FireAllClients({ text = message.Data })
	end
end

pcall(function()
	MessagingService:SubscribeAsync("GlobalAnnounceChannel", onMessageReceived)
end)
