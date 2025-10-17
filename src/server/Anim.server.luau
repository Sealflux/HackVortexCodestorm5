local CollectionService = game:GetService("CollectionService")

local function AnimateNpc(NPC)
	local hum = NPC:FindFirstChild("Humanoid")
	local animator = hum:FindFirstChild("Animator")
	local animation = NPC:FindFirstChild("Animation")
	local animTrack = animator:LoadAnimation(animation)
	animTrack.Looped = true
	animTrack.Priority = Enum.AnimationPriority.Idle
	animTrack:Play()
end
for i, NPC in ipairs(CollectionService:GetTagged("NPC")) do
	AnimateNpc(NPC)
end
