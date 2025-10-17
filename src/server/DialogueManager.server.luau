local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DialogueNPCS = ReplicatedStorage:WaitForChild("DialogueNPCS")
local DialogueEvent = ReplicatedStorage:FindFirstChild("Remotes"):FindFirstChild("Dialogue")
local PlayMedEvent = ReplicatedStorage:FindFirstChild("Remotes"):FindFirstChild("PlayMeditation")
local function AnimateNpc(NPC)
	local hum = NPC:FindFirstChild("Humanoid")
	local animator = hum:FindFirstChild("Animator")
	local animation = NPC:FindFirstChild("Animation")
	local animTrack = animator:LoadAnimation(animation)
	animTrack.Looped = true
	animTrack.Priority = Enum.AnimationPriority.Idle
	animTrack:Play()
end

local function Dialogue(plr, NPC)
	local PlayerGui = plr:WaitForChild("PlayerGui", 5)
	local Dialogue = PlayerGui:WaitForChild("Dialogue", 5)
	local VPF = Dialogue:FindFirstChild("ViewportFrame")
	local WorldModel = VPF:FindFirstChild("WorldModel")
	if Dialogue.Enabled == nil then
		NPC = DialogueNPCS:FindFirstChild(NPC):Clone()
		local CamValue = NPC:FindFirstChild("CamValue")
		local Camera = Instance.new("Camera")
		Camera.CFrame = CamValue.Value
		Camera.Parent = VPF
		VPF.CurrentCamera = Camera
		Camera.HeadLocked = true
		NPC.Parent = WorldModel
		AnimateNpc(NPC)
		task.wait(0.25)
		Dialogue.Enabled = true
		DialogueEvent:FireClient(plr, plr, NPC)
	elseif Dialogue.Enabled == false then
		NPC = DialogueNPCS:FindFirstChild(NPC):Clone()
		local CamValue = NPC:FindFirstChild("CamValue")
		local Camera = Instance.new("Camera")
		Camera.CFrame = CamValue.Value
		Camera.Parent = VPF
		VPF.CurrentCamera = Camera
		Camera.HeadLocked = true
		NPC.Parent = WorldModel
		AnimateNpc(NPC)
		task.wait(0.25)
		Dialogue.Enabled = true
		DialogueEvent:FireClient(plr, plr, NPC)
	else
		print("Dialogue already enabled.")
	end
end
local function GivePrompt(NPC)
	local ProximityPrompt = Instance.new("ProximityPrompt")
	ProximityPrompt.Parent = NPC
	ProximityPrompt.ActionText = "Talk"
	ProximityPrompt.Name = NPC.Name
	ProximityPrompt.HoldDuration = 0.35
	ProximityPrompt.Triggered:Connect(function(plr)
		Dialogue(plr, ProximityPrompt.Name)
	end)
end
DialogueEvent.OnServerEvent:Connect(function(plr)
	local PlayerGui = plr:WaitForChild("PlayerGui", 5)
	local Dialogue = PlayerGui:WaitForChild("Dialogue", 5)
	Dialogue.Enabled = false
	local VPF = Dialogue:FindFirstChild("ViewportFrame")
	local WorldModel = VPF:FindFirstChild("WorldModel")
	WorldModel:ClearAllChildren()
	VPF.CurrentCamera = nil
end)
PlayMedEvent.OnServerEvent:Connect(function(plr)
	PlayMedEvent:FireClient(plr, 4, 4, 5)
end)
for i, NPC in ipairs(CollectionService:GetTagged("NPC")) do
	print(NPC.Name .. " found in initial scan.")
	AnimateNpc(NPC)
	GivePrompt(NPC)
end
CollectionService:GetInstanceAddedSignal("NPC"):Connect(function(NPC)
	AnimateNpc(NPC)
	GivePrompt(NPC)
end)
