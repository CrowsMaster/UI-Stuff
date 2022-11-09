local module = {}
--[[
	Notification:Notify({
	Title = "Notification", -- Title of the notification
	Text = "This is a notification!", -- What will it say on notification
	Image = "rbxassetid://10686484299", -- Image on notification (delete this line if no image)
	Duration = 5, -- How long will notification stay on screen (if there are actions duration will be disabled for that notification)
	Actions = { -- You can add 2 actions (will ignore if there are more than 2)(changing code to have more will make it looj ugly)
		Close = { -- These names doesnt matter
			ButtonText = "Close",
			Callback = function()
				print("Button was pressed!") -- Add the code here
			end,
		}
	}
})
]]--
local TweenService = game:GetService("TweenService")
local Template = script:WaitForChild("Notification")
local ButtonTemplate = script:WaitForChild("TextButton")

if not game:GetService("StarterGui"):FindFirstChild("Notifications") then
	script:WaitForChild("Notifications"):Clone().Parent = game:GetService("StarterGui")
end

function module:Notify(Settings)
	local Player = game:GetService("Players").LocalPlayer
	local CloneNotif = Template:Clone()
	CloneNotif.Size = UDim2.new(1, 0, 0, 0)
	CloneNotif.Header.Text.Text = Settings.Title
	CloneNotif.Text.Text.Text = Settings.Text
	if Settings.Image then
		CloneNotif.Header.Image.Image = Settings.Image
	else
		CloneNotif.Header.Image.Visible = false
	end
	CloneNotif:SetAttribute("ActionCount", 0)
	if Settings.Actions then
		CloneNotif:SetAttribute("ActionCompleted", false)
		for i,action in pairs(Settings.Actions) do
			if CloneNotif:GetAttribute("ActionCount") == 2 then
				break
			end
			local newButton = ButtonTemplate:Clone()
			newButton.Parent = CloneNotif.Buttons
			newButton.Name = action.ButtonText
			newButton.Text = action.ButtonText
			CloneNotif:SetAttribute("ActionCount", CloneNotif:GetAttribute("ActionCount") + 1)
			
			newButton.MouseButton1Click:Connect(function()
				action.Callback()
				CloneNotif:SetAttribute("ActionCompleted", true)
			end)
		end
	else
		CloneNotif.Buttons.Visible = false
		CloneNotif.Header.Size = UDim2.new(0.938, 0, 0.312, 0)
		CloneNotif.Text.Size = UDim2.new(0.95, 0, 0.598, 0)
		CloneNotif:SetAttribute("ActionCompleted", true)
	end
	CloneNotif.Parent = Player.PlayerGui:WaitForChild("Notifications"):WaitForChild("NotificationsFrame")
	wait(.1)
	if Settings.Actions then
		TweenService:Create(CloneNotif, TweenInfo.new(.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 0.359, 0)}):Play()
	else
		TweenService:Create(CloneNotif, TweenInfo.new(.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 0.234, 0)}):Play()
	end	

	if Settings.Actions then
		wait(.1)
	else
		wait(Settings.Duration)
	end

	if CloneNotif:GetAttribute("ActionCompleted") == true then
		TweenService:Create(CloneNotif, TweenInfo.new(.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 0, 0)}):Play()
	else
		CloneNotif:GetAttributeChangedSignal("ActionCompleted"):Connect(function()
			if CloneNotif:GetAttribute("ActionCompleted") == true then
				TweenService:Create(CloneNotif, TweenInfo.new(.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 0, 0)}):Play()
				wait(.6)
				CloneNotif:Destroy()
			end
		end)
	end
end

return module
