local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- UiInit (LocalScript in StarterGui)
local Player: Player = game.Players.LocalPlayer

local UiManager = require(ReplicatedStorage.Shared.Client.UiManager)

-- Function to initialize the UI manager for the current player
local function InitUiManager()
	-- Create a new controller instance for the new GUI
	local Manager = UiManager.new(Player)
	return Manager
end

-- Initialize for the first time
local Manager = InitUiManager()
print("UI Manager initialized for player: " .. Player.Name)

-- Listen for when the player's character (and thus PlayerGui) is removed
Player.CharacterRemoving:Connect(function()
	-- Destroy the old controller to clean up its connections
	-- This is VITAL to prevent memory leaks from old event connections
	if Manager then
		Manager:Destroy()
		Manager = nil
	end
	Manager = InitUiManager()
end)

-- Listen for when a new character (and thus a new PlayerGui) is added
Player.CharacterAdded:Connect(function()
	-- Wait a brief moment for the PlayerGui to be recreated and populated
	task.wait(0.5) -- A short delay is often necessary
	-- Reinitialize the Manager
	Manager = InitUiManager()
end)
