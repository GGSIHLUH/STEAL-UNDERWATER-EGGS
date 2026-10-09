local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Bersihin UI lama kalo ada
if PlayerGui:FindFirstChild("AresHub_UI") then
	PlayerGui.AresHub_UI:Destroy()
end

-- State Features dari Script Baru
local States = {
	AutoBuyFin = false,
	UpgradeTank = false,
	SellAll = false,
	AutoSteal = {
		["Coral Reef"] = false,
		["Kelp Forest"] = false,
		["Claw Canyon"] = false,
		["Ship Graveyard"] = false,
		["Lava Fortress"] = false,
		["Jungle Temple"] = false,
		["Frost Abyss"] = false,
		["Atlantis"] = false
	}
}

-- ScreenGui Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AresHub_UI"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 100
ScreenGui.Parent = PlayerGui

-- Floating Icon
local FloatingIcon = Instance.new("ImageButton", ScreenGui)
FloatingIcon.Name = "AresFloatingIcon"
FloatingIcon.Size = UDim2.new(0, 50, 0, 50)
FloatingIcon.Position = UDim2.new(0.02, 0, 0.25, 0)
FloatingIcon.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
FloatingIcon.Image = "rbxassetid://94158239411156"
FloatingIcon.Active = true
FloatingIcon.Draggable = true

Instance.new("UICorner", FloatingIcon).CornerRadius = UDim.new(0, 10)
local IconStroke = Instance.new("UIStroke", FloatingIcon)
IconStroke.Thickness = 1.5
IconStroke.Color = Color3.fromRGB(60, 60, 60)

-- Main Frame
local MainFrame = Instance.new("ImageLabel", ScreenGui)
MainFrame.Name = "AresMainFrame"
MainFrame.Size = UDim2.new(0, 520, 0, 320)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -160)
MainFrame.Image = "rbxassetid://107592201437230"
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)
local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Thickness = 1
MainStroke.Color = Color3.fromRGB(45, 45, 50)

-- Header
local TopBar = Instance.new("Frame", MainFrame)
TopBar.Size = UDim2.new(1, 0, 0, 35)
TopBar.BackgroundTransparency = 1

local HubTitle = Instance.new("TextLabel", TopBar)
HubTitle.Size = UDim2.new(0, 200, 1, 0)
HubTitle.Position = UDim2.new(0, 15, 0, 0)
HubTitle.BackgroundTransparency = 1
HubTitle.Text = "Ares Hub - USE KEY"
HubTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
HubTitle.Font = Enum.Font.GothamBold
HubTitle.TextSize = 13
HubTitle.TextXAlignment = Enum.TextXAlignment.Left

local CloseBtn = Instance.new("TextButton", TopBar)
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 2)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "Hide"
CloseBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
CloseBtn.Font = Enum.Font.GothamMedium
CloseBtn.TextSize = 14

CloseBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false end)
FloatingIcon.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

-- Content Area
local ContentFrame = Instance.new("Frame", MainFrame)
ContentFrame.Size = UDim2.new(1, -20, 1, -45)
ContentFrame.Position = UDim2.new(0, 10, 0, 38)
ContentFrame.BackgroundTransparency = 1

local LeftColumn = Instance.new("ScrollingFrame", ContentFrame)
LeftColumn.Size = UDim2.new(0.5, -5, 1, 0)
LeftColumn.Position = UDim2.new(0, 0, 0, 0)
LeftColumn.BackgroundTransparency = 1
LeftColumn.ScrollBarThickness = 2
LeftColumn.BorderSizePixel = 0

local RightColumn = Instance.new("ScrollingFrame", ContentFrame)
RightColumn.Size = UDim2.new(0.5, -5, 1, 0)
RightColumn.Position = UDim2.new(0.5, 5, 0, 0)
RightColumn.BackgroundTransparency = 1
RightColumn.ScrollBarThickness = 2
RightColumn.BorderSizePixel = 0

Instance.new("UIListLayout", LeftColumn).Padding = UDim.new(0, 6)
Instance.new("UIListLayout", RightColumn).Padding = UDim.new(0, 6)

-- Library Builder
local Library = {}

function Library:AddToggle(parent, text, default, callback)
	local ToggleFrame = Instance.new("Frame", parent)
	ToggleFrame.Size = UDim2.new(1, -6, 0, 26)
	ToggleFrame.BackgroundTransparency = 1

	local Label = Instance.new("TextLabel", ToggleFrame)
	Label.Size = UDim2.new(0.7, 0, 1, 0)
	Label.BackgroundTransparency = 1
	Label.Text = text
	Label.TextColor3 = Color3.fromRGB(200, 200, 200)
	Label.Font = Enum.Font.Gotham
	Label.TextSize = 10
	Label.TextXAlignment = Enum.TextXAlignment.Left

	local Switch = Instance.new("TextButton", ToggleFrame)
	Switch.Size = UDim2.new(0, 32, 0, 16)
	Switch.Position = UDim2.new(1, -35, 0.5, -8)
	Switch.BackgroundColor3 = default and Color3.fromRGB(0, 180, 255) or Color3.fromRGB(50, 50, 55)
	Switch.Text = ""

	Instance.new("UICorner", Switch).CornerRadius = UDim.new(1, 0)

	local Circle = Instance.new("Frame", Switch)
	Circle.Size = UDim2.new(0, 12, 0, 12)
	Circle.Position = default and UDim2.new(1, -14, 0.5, -6) or UDim2.new(0, 2, 0.5, -6)
	Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Instance.new("UICorner", Circle).CornerRadius = UDim.new(1, 0)

	local state = default
	Switch.MouseButton1Click:Connect(function()
		state = not state
		if state then
			Switch.BackgroundColor3 = Color3.fromRGB(0, 180, 255)
			Circle.Position = UDim2.new(1, -14, 0.5, -6)
		else
			Switch.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
			Circle.Position = UDim2.new(0, 2, 0.5, -6)
		end
		callback(state)
	end)
end

-- ==========================================
-- MENU TOGGLE DARI SCRIPT BARU
-- ==========================================

-- Left Column: Auto Steal Zones
local Zones = {
	"Coral Reef", "Kelp Forest", "Claw Canyon", "Ship Graveyard",
	"Lava Fortress", "Jungle Temple", "Frost Abyss", "Atlantis"
}

for _, zoneName in ipairs(Zones) do
	Library:AddToggle(LeftColumn, "Steal: " .. zoneName, false, function(v)
		States.AutoSteal[zoneName] = v
	end)
end

-- Right Column: Upgrades & Shop
Library:AddToggle(RightColumn, "Auto Buy Fin", false, function(v)
	States.AutoBuyFin = v
end)

Library:AddToggle(RightColumn, "Upgrade Tank", false, function(v)
	States.UpgradeTank = v
end)

Library:AddToggle(RightColumn, "Sell All", false, function(v)
	States.SellAll = v
end)

-- ==========================================
-- ENGINE BACKEND LOGIC DARI FILE
-- ==========================================

task.spawn(function()
	while task.wait(0.5) do
		pcall(function()
			-- Logic Auto Steal Zone
			for zone, enabled in pairs(States.AutoSteal) do
				if enabled then
					local remote = ReplicatedStorage:FindFirstChild("StealEgg", true) or ReplicatedStorage:FindFirstChild("Events", true)
					if remote then
						remote:FireServer(zone)
					end
				end
			end

			-- Logic Auto Buy Fin
			if States.AutoBuyFin then
				local finRemote = ReplicatedStorage:FindFirstChild("BuyFin", true)
				if finRemote then finRemote:FireServer() end
			end

			-- Logic Upgrade Tank
			if States.UpgradeTank then
				local tankRemote = ReplicatedStorage:FindFirstChild("UpgradeTank", true)
				if tankRemote then tankRemote:FireServer() end
			end

			-- Logic Sell All
			if States.SellAll then
				local sellRemote = ReplicatedStorage:FindFirstChild("SellAll", true) or ReplicatedStorage:FindFirstChild("Sell", true)
				if sellRemote then sellRemote:FireServer() end
			end
		end)
	end
end)
