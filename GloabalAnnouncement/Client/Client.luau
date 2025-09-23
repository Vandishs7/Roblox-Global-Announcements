local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local textButton = script.Parent
textButton.Visible = false
textButton.BackgroundTransparency = 1

local function showButton(text)
	textButton.Text = text
	textButton.Visible = true
	local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
	local tweenIn = TweenService:Create(textButton, tweenInfo, {BackgroundTransparency = 0})
	tweenIn:Play()
	task.wait(10)
	local tweenOut = TweenService:Create(textButton, tweenInfo, {BackgroundTransparency = 1})
	tweenOut:Play()
	tweenOut.Completed:Wait()
	textButton.Visible = false
end

ReplicatedStorage.Remotes:WaitForChild("glblanc").OnClientEvent:Connect(function(PL)
	if PL and PL.text then
		showButton(PL.text)
	end
end)
