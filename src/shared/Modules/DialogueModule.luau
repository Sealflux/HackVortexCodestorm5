local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DisplayText = require(ReplicatedStorage.Shared.Modules.DisplayText)
local DialogueModule = {}

-- NPC Dialogue Database (Key = NPC Name, Value = Dialogue Table)
local NPC_DIALOGUE = {
	["anthien00"] = {
		"Find peace in stillness. Sometimes the most powerful thing you can do is simply be present.",
		"Notice the details around you - the way light falls, the colors in the sky. Mindfulness begins with observation.",
		"When thoughts race, return to your breath. It's your anchor in every storm.",
	},
	["fluxfluxduck"] = {
		"Feeling overwhelmed? Let's practice some calming breaths together. Just follow the rhythm.",
		"Breathing is your body's natural reset button. Shall we press it together?",
	},
	["waterpipe5177"] = {
		"Like water, your breath can flow smoothly and wash away stress. Let it move through you naturally.",
		"Be as kind to yourself as you would be to a still pond - without judgment, without disturbance.",
		"Each breath is a new beginning. What will you let go of with your next exhale?",
	},
}

-- Get all dialogue lines for an NPC
function DialogueModule.GetDialogue(NPC)
	return NPC_DIALOGUE[NPC] or { "...", "...", "..." } -- Default fallback
end

-- Get a specific line (or random if no lineNumber provided)
function DialogueModule.GetLine(NPC, lineNumber)
	local dialogue = NPC_DIALOGUE[NPC]
	if not dialogue then
		return "..."
	end

	if lineNumber then
		return dialogue[lineNumber] or dialogue[#dialogue] -- Default to last line
	else
		-- Return a random line
		return dialogue[math.random(1, #dialogue)]
	end
end

return DialogueModule
