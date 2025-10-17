local plrs = game:GetService("Players")
local PhysicsService = game:GetService("PhysicsService")

local GroupName = "Players"

PhysicsService:RegisterCollisionGroup(GroupName)
PhysicsService:CollisionGroupSetCollidable(GroupName, GroupName, false)

local function ChangeGroup(part)
	if part:IsA("BasePart") then
		part.CollisionGroup = GroupName
	end
end

local function HandleCharAdded(char)
	for i, part in ipairs(char:GetChildren()) do
		ChangeGroup(part)
	end
end

plrs.PlayerAdded:Connect(function(plr)
	plr.CharacterAdded:Connect(function(char)
		HandleCharAdded(char)

		char.ChildAdded:Connect(function(child)
			ChangeGroup(child)
		end)
	end)
end)
