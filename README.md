# UI-Stuff
This repository includes some UI modules for Roblox. 
These modules make some stuff easy.

Get the model from Roblox website [here](https://create.roblox.com/marketplace/asset/11377872227/UI-Modules).

## Custom Notifications
- Download the Notification.rbxm file and insert it into your game.
- Put the module into anywhere you want.
- Send notifications with this code.
```lua
local Notification = require(game:GetService("ReplicatedStorage"):WaitForChild("Notification"))
-- This expects Notification module to be in ReplicatedStorage
 
Notification:Notify({
	Title = "Notification", -- Title of the notification
	Text = "This is a notification!", -- What will it say on notification
	Image = "rbxassetid://10686484299", -- Image on notification (delete this line if no image)
	Duration = 5, -- How long will notification stay on screen (if there are actions, duration will be disabled for that notification)
	Actions = { -- You can add 2 actions, remove this part to have no actions(will ignore if there are more than 2)(changing code to have more will make it look ugly)
		Close = { -- These names doesnt matter
			ButtonText = "Close", -- What will it say on button
			Callback = function()
				print("Button was pressed!") -- This code will run when button is pressed
			end,
		}
	}
})
```

## Sliders
- Download the Slider.rbxm file and insert it into your game.
- Put the module anywhere you want.
- Set sliders with this code. (Can't be vertical.)
```lua
local SliderModule = require(game:GetService("ReplicatedStorage"):WaitForChild("Slider"))
-- This expects Slider module to be in ReplicatedStorage

SliderModule.AddSlider({
	Slider = GuiObject, -- Slider Frame
	Name = "Example",
	Range = {8, 200},
	Increment = 2,
	CurrentValue = 16, -- This is like the default value of slider.
	Callback = function(Value) -- Value is the value that the slider is changed to
		print(Value) -- Value will change ever time slider is used
	end
})
```
