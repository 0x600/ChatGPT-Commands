local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")

local SendData = ReplicatedStorage:WaitForChild("SendData")
local FireCode = ReplicatedStorage:WaitForChild("FireCode")

SendData.OnClientEvent:Connect(function(Message)
	StarterGui:SetCore("ChatMakeSystemMessage", {
		Text=`[ChatGPT]: {Message}`
	})
end)
