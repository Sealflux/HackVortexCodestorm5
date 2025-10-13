local UiManager = {}
UiManager.__index = UiManager

function UiManager.new(Player)
	local self = setmetatable({}, UiManager)
	self.Player = Player
	self.PlayerGui = self.Player:WaitForChild("PlayerGui")
	self.MainGui = self.PlayerGui:WaitForChild("MainGui")
	self.TweenService = game:GetService("TweenService")
	self.MeditationFrame = self.MainGui:WaitForChild("MeditationFrame")
	self.MeditationFrameTopBar = self.MeditationFrame:WaitForChild("TopBar"):WaitForChild("Fill")
	self.MeditationFrameRightBar = self.MeditationFrame:WaitForChild("RightBar"):WaitForChild("Fill")
	self.MeditationFrameLeftBar = self.MeditationFrame:WaitForChild("LeftBar"):WaitForChild("Fill")
	self.MeditationFrameBottomBar = self.MeditationFrame:WaitForChild("BottomBar"):WaitForChild("Fill")
	self.ToggleTest = self.MeditationFrame:WaitForChild("TextButton")

	self.ToggleTest.MouseButton1Click:Connect(function()
		self:PlayMeditation(4, 4, 5)
	end)

	return self
end

function UiManager:PlayMeditation(InhaleDuration, ExhaleDuration, HoldDuration)
	-- Ensure bars are properly anchored before starting
	self:SetupBarAnchors()

	self.MeditationFrameTopBar.Visible = true

	-- Inhale (Top bar - right to left)
	local InhaleTweenInfo = TweenInfo.new(InhaleDuration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
	local Inhale = game:GetService("TweenService"):Create(
		self.MeditationFrameTopBar,
		InhaleTweenInfo,
		{ Size = UDim2.new(1, 0, 1, 0) } -- Expands to full width
	)
	Inhale:Play()
	Inhale.Completed:Wait()

	-- Hold (Right bar - top to bottom)
	local HoldTweenInfo = TweenInfo.new(HoldDuration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
	local Hold1 = game:GetService("TweenService"):Create(
		self.MeditationFrameRightBar,
		HoldTweenInfo,
		{ Size = UDim2.new(1, 0, 1, 0) } -- Expands to full height
	)
	self.MeditationFrameRightBar.Visible = true
	Hold1:Play()
	Hold1.Completed:Wait()

	-- Exhale (Bottom bar - right to left)
	local ExhaleTweenInfo = TweenInfo.new(ExhaleDuration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
	local Exhale = game:GetService("TweenService"):Create(
		self.MeditationFrameBottomBar,
		ExhaleTweenInfo,
		{ Size = UDim2.new(1, 0, 1, 0) } -- Expands to full width (right to left)
	)
	self.MeditationFrameBottomBar.Visible = true
	Exhale:Play()
	Exhale.Completed:Wait()

	-- Final Hold (Left bar - bottom to top)
	local Hold2 = game:GetService("TweenService"):Create(
		self.MeditationFrameLeftBar,
		HoldTweenInfo,
		{ Size = UDim2.new(1, 0, 1, 0) } -- Expands to full height
	)
	self.MeditationFrameLeftBar.Visible = true
	Hold2:Play()
	Hold2.Completed:Wait()

	self:ResetBars()
end

function UiManager:SetupBarAnchors()
	-- Top bar: anchor left, start from left (left to right)
	self.MeditationFrameTopBar.AnchorPoint = Vector2.new(0, 0)
	self.MeditationFrameTopBar.Position = UDim2.new(0, 0, 0, 0)
	self.MeditationFrameTopBar.Size = UDim2.new(0, 0, 1, 0) -- Start collapsed at left

	-- Right bar: anchor top, start from top (top to bottom)
	self.MeditationFrameRightBar.AnchorPoint = Vector2.new(1, 0)
	self.MeditationFrameRightBar.Position = UDim2.new(1, 0, 0, 0)
	self.MeditationFrameRightBar.Size = UDim2.new(1, 0, 0, 0) -- Start collapsed at top

	-- Bottom bar: anchor right, start from right (right to left)
	self.MeditationFrameBottomBar.AnchorPoint = Vector2.new(1, 1)
	self.MeditationFrameBottomBar.Position = UDim2.new(1, 0, 1, 0)
	self.MeditationFrameBottomBar.Size = UDim2.new(0, 0, 1, 0) -- Start collapsed at right

	-- Left bar: anchor bottom, start from bottom (bottom to top)
	self.MeditationFrameLeftBar.AnchorPoint = Vector2.new(0, 1)
	self.MeditationFrameLeftBar.Position = UDim2.new(0, 0, 1, 0)
	self.MeditationFrameLeftBar.Size = UDim2.new(1, 0, 0, 0) -- Start collapsed at bottom
end

function UiManager:ResetBars()
	-- Reset all bars to their collapsed state (matching SetupBarAnchors)
	self.MeditationFrameTopBar.Size = UDim2.new(0, 0, 1, 0) -- Top: collapsed at left
	self.MeditationFrameRightBar.Size = UDim2.new(1, 0, 0, 0) -- Right: collapsed at top
	self.MeditationFrameBottomBar.Size = UDim2.new(0, 0, 1, 0) -- Bottom: collapsed at right
	self.MeditationFrameLeftBar.Size = UDim2.new(1, 0, 0, 0) -- Left: collapsed at bottom

	self.MeditationFrameTopBar.Visible = false
	self.MeditationFrameRightBar.Visible = false
	self.MeditationFrameBottomBar.Visible = false
	self.MeditationFrameLeftBar.Visible = false
end

return UiManager
