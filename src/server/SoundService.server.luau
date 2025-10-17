local SoundService = game:GetService("SoundService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local relaxationMusic = ReplicatedStorage:WaitForChild("Sound"):WaitForChild("RelaxationMusic"):Clone()
relaxationMusic.Looped = true
relaxationMusic.Volume = 0.5
relaxationMusic.Parent = SoundService

-- Play for all players when they join
Players.PlayerAdded:Connect(function(player)
	relaxationMusic:Play()
end)

-- Also play immediately if there are already players
if #Players:GetPlayers() > 0 then
	relaxationMusic:Play()
end
