local UiManager = {}
UiManager.__index = UiManager

function UiManager.new(Player)
	local self = setmetatable({}, UiManager)
	self.Player = Player
	self.PlayerGui = self.Player:WaitForChild("PlayerGui")
	self.MainGui = self.PlayerGui:WaitForChild("MainGui")
	self.TweenService = game:GetService("TweenService")
	self.MeditationFrame = self.MainGui:WaitForChild("MeditationFrame")
	self.MeditationFrameOxygenBar = self.MeditationFrame:WaitForChild("OxygenBar"):WaitForChild("Fill")
	self.MeditationText = self.MeditationFrame:WaitForChild("MeditationText")

	return self
end
function UiManager:DisplayMeditationText(Text)
	self.MeditationText.Text = Text
end
function UiManager:PlayMeditation(InhaleDuration, ExhaleDuration, HoldDuration)
	self.MainGui.Enabled = true
	-- Ensure bars are properly anchored before starting
	self:SetupBarAnchor()

	local InhaleTweenInfo = TweenInfo.new(InhaleDuration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
	-- Inhale (Oxygen bar - bottom to top)
	local Inhale = game:GetService("TweenService"):Create(
		self.MeditationFrameOxygenBar,
		InhaleTweenInfo,
		{ Size = UDim2.new(1, 0, 1, 0) } -- Expands to full height
	)
	self:DisplayMeditationText("Inhale")
	self.MeditationFrameOxygenBar.Visible = true
	Inhale:Play()
	Inhale.Completed:Wait()
	self:DisplayMeditationText("Hold.")
	task.wait(HoldDuration / 4)
	self:DisplayMeditationText("Hold..")
	task.wait(HoldDuration / 4)
	self:DisplayMeditationText("Hold...")
	task.wait(HoldDuration / 4)
	self:DisplayMeditationText("Final Stretch...")
	task.wait(HoldDuration / 4)

	-- Exhale (Oxygen bar - top to bottom)
	local ExhaleTweenInfo = TweenInfo.new(ExhaleDuration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
	local Exhale = game:GetService("TweenService"):Create(
		self.MeditationFrameOxygenBar,
		ExhaleTweenInfo,
		{ Size = UDim2.new(1, 0, 0, 0) } -- Collapses to zero height
	)
	self:DisplayMeditationText("Exhale")
	self.MeditationFrameOxygenBar.Visible = true
	Exhale:Play()
	Exhale.Completed:Wait()
	self:DisplayMeditationText("Hold.")
	task.wait(HoldDuration / 4)
	self:DisplayMeditationText("Hold..")
	task.wait(HoldDuration / 4)
	self:DisplayMeditationText("Hold...")
	task.wait(HoldDuration / 4)
	self:DisplayMeditationText("Final Stretch...")
	task.wait(HoldDuration / 4)

	self:ResetBar()
	self.MainGui.Enabled = false
end

function UiManager:SetupBarAnchor()
	-- Oxygen bar: anchor bottom, start from bottom (bottom to top)
	self.MeditationFrameOxygenBar.AnchorPoint = Vector2.new(0, 1)
	self.MeditationFrameOxygenBar.Position = UDim2.new(0, 0, 1, 0)
	self.MeditationFrameOxygenBar.Size = UDim2.new(1, 0, 0, 0) -- Start collapsed at bottom
end

function UiManager:ResetBar()
	self.MeditationFrameOxygenBar.Size = UDim2.new(1, 0, 0, 0) -- Oxygen: collapsed at bottom
	self.MeditationFrameOxygenBar.Visible = false
end

return UiManager
