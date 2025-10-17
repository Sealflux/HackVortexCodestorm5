local DisplayText = {}
local KeyPress = game.ReplicatedStorage.Sound.KeyPress

function DisplayText.TypeText(TextBox, message: string)
	local TextDisplay = TextBox
	TextDisplay.Text = ""
	for i = 1, #message do
		TextDisplay.Text = string.sub(message, 1, i)
		KeyPress:Play() -- Play sound per letter
		task.wait(0.05)
	end
	KeyPress:Stop()
end
return DisplayText
