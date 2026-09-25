-- ====================================================================
-- MAIN PANEL INITIALIZATION
-- ====================================================================
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- 1. Create the main ScreenGui container
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BladeBallDevMenu"
screenGui.ResetOnSpawn = false
screenGui.Parent = PlayerGui

-- 2. Create the main background frame (The red box from your Studio setup)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 300, 0, 200)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -100) -- Perfectly centered on screen
mainFrame.BackgroundColor3 = Color3.fromRGB(200, 50, 50) -- Matches your red design
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- 3. Add the Title Text Label
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "BladeBallTitle"
titleLabel.Size = UDim2.new(1, 0, 0, 40)
titleLabel.Position = UDim2.new(0, 0, 0, 10)
titleLabel.Text = "Blade Ball Menu"
titleLabel.TextSize = 24
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.BackgroundTransparency = 1
titleLabel.Parent = mainFrame

-- 4. Create the Checkbox / Toggle Button
local toggleBox = Instance.new("TextButton")
toggleBox.Name = "ToggleBox"
toggleBox.Size = UDim2.new(0, 40, 0, 40)
toggleBox.Position = UDim2.new(0.5, -20, 0.5, 0) -- Positioned cleanly in the middle
toggleBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- Starts white (OFF)
toggleBox.Text = "" -- Starts blank
toggleBox.TextSize = 20
toggleBox.Font = Enum.Font.SourceSansBold
toggleBox.Parent = mainFrame


-- ====================================================================
-- FEATURE: DRAGGABLE PANEL MECHANIC
-- ====================================================================
local dragging, dragInput, dragStart, startPos

local function updateDrag(input)
	local delta = input.Position - dragStart
	mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

mainFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = mainFrame.Position
		
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

mainFrame.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		updateDrag(input)
	end
end)


-- ====================================================================
-- FEATURE: TOGGLE GREEN BUTTON MECHANIC
-- ====================================================================
local isChecked = false
local CHECKED_COLOR = Color3.fromRGB(0, 200, 0)      -- Vibrant Green when ON
local UNCHECKED_COLOR = Color3.fromRGB(255, 255, 255) -- Plain White when OFF

local function onButtonClicked()
	isChecked = not isChecked
	
	if isChecked then
		-- Visual representation for ON
		toggleBox.BackgroundColor3 = CHECKED_COLOR
		toggleBox.Text = "✓"
		toggleBox.TextColor3 = Color3.fromRGB(255, 255, 255)
		
		print("Custom Feature is now active!")
	else
		-- Visual representation for OFF
		toggleBox.BackgroundColor3 = UNCHECKED_COLOR
		toggleBox.Text = ""
		
		print("Custom Feature is now disabled!")
	end
end

toggleBox.MouseButton1Click:Connect(onButtonClicked)

