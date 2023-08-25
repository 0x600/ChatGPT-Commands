local HTTPService = game:GetService("HttpService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local SendData = ReplicatedStorage:WaitForChild("SendData")
local FireCode = ReplicatedStorage:WaitForChild("FireCode")

local Settings = {
	URL = "https://api.openai.com/v1/chat/completions",
	Authorization = "Bearer YOUR-API-SECRET-KEY"
}

local Headers = {
	["Authorization"] = Settings.Authorization
}

Players.PlayerAdded:Connect(function(Player)
	Player.Chatted:Connect(function(Message)
		local Split = Message:gmatch("[^%s]+")
		
		local Arguments = {}
		
		for Argument in Split do
			table.insert(Arguments, Argument)
		end
		
		if Arguments[1] == ".askgpt" then
			table.remove(Arguments, 1)
			
			local Body = HTTPService:JSONEncode({
				model = "gpt-3.5-turbo",
				messages = {{
					role = "user",
					content = table.concat(Arguments, " ", 1)
				}}
			})

			local Response = HTTPService:PostAsync(Settings.URL, Body, Enum.HttpContentType.ApplicationJson, nil, Headers)
			local Decoded = HTTPService:JSONDecode(Response)
			local Message = Decoded["choices"][1]["message"]["content"]

			SendData:FireClient(Player, Message)
		end
	end)
end)
