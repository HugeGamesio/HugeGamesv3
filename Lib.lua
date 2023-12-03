
-- UI v2
-- Dropdowns + DropDowns Within Nested Sections (Yay)
-- discord.gg/hugegames


local UILib = {}

local DisableExperimentalDragging = true
local DisableMovementRotation = true
local MovementTweenTime = .15
local isUsingSlider = false

-- Original Sizes

local MainFrameSize = UDim2.new(0, 480, 0, 277)
local NewPageSize = UDim2.new(0,360, 0, 263)
local BaseSection_Size = UDim2.new(0, 306, 0, 40)
local Section_LabelSize = UDim2.new(0, 306, 0, 25)
local BaseItemSize_Section = UDim2.new(0, 290, 0, 30)
local Section_MainLabelSize = UDim2.new(0, 290, 0, 25)
local BaseItemSize_Nested = UDim2.new(0, 250, 0, 30)
local Mult = 0.9


local function CalculateSize(Frame, List, Scale) -- ACS For Scaling, Don't ask ok.f
	local Scale = Scale or 1
	local YSize = 0
	local Items = 0
	for i,v in pairs(Frame:GetChildren()) do
		if v:IsA("Frame") then
			YSize = YSize + v.AbsoluteSize.Y
			Items = Items + 1
		end
	end
	YSize = YSize + (List.Padding.Offset*Scale)*(Items-1)
	return YSize/Scale + (10)
end

function UILib:CreateUI()
	local Window = {
		tabs = {}
	}
	local T = {}
	local selectedButton = nil
	local sectionedElements = {}
	local dropdownFrames = {}
	local oldSizes = {}


	local isDragging = false
	local lastMousePosition = nil
	local tiltSpeed = 0.1 
	local maxTiltAngle = 10 

	local HugeUI = Instance.new("ScreenGui")

	local Scaleable = Instance.new("UIScale", HugeUI)
	Scaleable.Scale = 1 -- Changing breaks ACS

	function Window:SetScale(Scale, Tween)
		if Tween then
			game.TweenService:Create(
				Scaleable,
				Tween,
				{Scale = Scale}
			):Play()
		else
			Scaleable.Scale = Scale
		end
	end


	local Constraint = Instance.new("Frame")

	function Window:Destroy()
		Constraint:Destroy()
	end


	local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
	local Frame = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local Background = Instance.new("ImageLabel")
	local UICorner_2 = Instance.new("UICorner")
	local Darken = Instance.new("Frame")
	local UICorner_3 = Instance.new("UICorner")
	local Sidebar = Instance.new("Frame")
	local UICorner_4 = Instance.new("UICorner")
	local FlatEdge = Instance.new("Frame")
	local ImageLabel = Instance.new("ImageLabel")
	local ScrollingFrame = Instance.new("ScrollingFrame")
	local UIListLayout = Instance.new("UIListLayout")
	local AccountSec = Instance.new("Frame")
	local UICorner_5 = Instance.new("UICorner")
	local ImageLabel_2 = Instance.new("ImageLabel")
	local UICorner_6 = Instance.new("UICorner")
	local UIAspectRatioConstraint_2 = Instance.new("UIAspectRatioConstraint")
	local TextLabel = Instance.new("TextLabel")
	local TextLabel_2 = Instance.new("TextLabel")
	local MainSection = Instance.new("Frame")

	local dragging
	local dragInput
	local dragStart
	local startPos

	local function update(input)
		local delta = input.Position - dragStart
		local NewPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X / Scaleable.Scale, startPos.Y.Scale, startPos.Y.Offset + delta.Y / Scaleable.Scale)
		game.TweenService:Create(Frame, TweenInfo.new(MovementTweenTime), {Position=NewPos}):Play()
	end

	Frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 and (not isUsingSlider) then
			dragging = true
			dragStart = input.Position
			startPos = Frame.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	Frame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement and (not isUsingSlider) then
			dragInput = input
		end
	end)

	game:GetService("UserInputService").InputChanged:Connect(function(input)
		if input == dragInput and dragging and (not isUsingSlider) then
			update(input)
		end
	end)


	HugeUI.Name = "HugeUI"
	HugeUI.Parent = (game["Run Service"]:IsStudio() and game.Players.LocalPlayer:WaitForChild("PlayerGui")) or game.CoreGui
	--HugeUI.Parnet = game.CoreGui
	HugeUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	Constraint.Name = "Constraint"
	Constraint.Parent = HugeUI
	Constraint.BackgroundColor3 = Color3.new(1, 1, 1)
	Constraint.BackgroundTransparency = 1
	Constraint.BorderColor3 = Color3.new(0, 0, 0)
	Constraint.BorderSizePixel = 0
	Constraint.Position = UDim2.new(0.5, 0, 0.5, 0)
	Constraint.Size = UDim2.new(0.295668066, 0, 0.628745854, 0)
	Constraint.AnchorPoint = Vector2.new(.5, .5)

	UIAspectRatioConstraint.Parent = Constraint

	Frame.Parent = Constraint
	Frame.AnchorPoint = Vector2.new(0.5, 0.5)
	Frame.BackgroundColor3 = Color3.new(1, 1, 1)
	Frame.BorderColor3 = Color3.new(0, 0, 0)
	Frame.BorderSizePixel = 0
	Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
	Frame.Size = MainFrameSize

	UICorner.Parent = Frame

	Background.Name = "Background"
	Background.Parent = Frame
	Background.BackgroundColor3 = Color3.new(1, 1, 1)
	Background.BorderColor3 = Color3.new(0, 0, 0)
	Background.BorderSizePixel = 0
	Background.Size = UDim2.new(1, 0, 1, 0)
	Background.Image = "rbxassetid://15407424199"

	UICorner_2.Parent = Background

	Darken.Name = "Darken"
	Darken.Parent = Background
	Darken.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
	Darken.BackgroundTransparency = 0.20000000298023224
	Darken.BorderColor3 = Color3.new(0, 0, 0)
	Darken.BorderSizePixel = 0
	Darken.Size = UDim2.new(1, 0, 1, 0)

	UICorner_3.Parent = Darken

	Sidebar.Name = "Sidebar"
	Sidebar.Parent = Frame
	Sidebar.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
	Sidebar.BorderColor3 = Color3.new(0, 0, 0)
	Sidebar.BorderSizePixel = 0
	Sidebar.Size = UDim2.new(0.224999994, 0, 1, 0)

	UICorner_4.Parent = Sidebar

	FlatEdge.Name = "FlatEdge"
	FlatEdge.Parent = Sidebar
	FlatEdge.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
	FlatEdge.BorderColor3 = Color3.new(0, 0, 0)
	FlatEdge.BorderSizePixel = 0
	FlatEdge.Position = UDim2.new(0.768853605, 0, 0, 0)
	FlatEdge.Size = UDim2.new(0.224999994, 0, 1, 0)
	FlatEdge.ZIndex = -1

	ImageLabel.Parent = Sidebar
	ImageLabel.BackgroundColor3 = Color3.new(1, 1, 1)
	ImageLabel.BackgroundTransparency = 1
	ImageLabel.BorderColor3 = Color3.new(0, 0, 0)
	ImageLabel.BorderSizePixel = 0
	ImageLabel.Position = UDim2.new(0.155485526, 0, 0.0275019091, 0)
	ImageLabel.Size = UDim2.new(0.674392283, 0, 0.190794498, 0)
	ImageLabel.Image = "rbxassetid://15407461567"
	
	local ScrollHolder = Instance.new("Frame")
	ScrollHolder.Parent = Sidebar
	ScrollHolder.Active = true
	ScrollHolder.BackgroundColor3 = Color3.new(1, 1, 1)
	ScrollHolder.BackgroundTransparency = 1
	ScrollHolder.BorderColor3 = Color3.new(0, 0, 0)
	ScrollHolder.BorderSizePixel = 0
	ScrollHolder.Position = UDim2.new(-0.00784544554, 0, 0.247517183, 0)
	ScrollHolder.Size = UDim2.new(1, 0, 0.55, 0)
	ScrollHolder.ClipsDescendants = true
	
	ScrollingFrame.Parent = ScrollHolder
	ScrollingFrame.Active = true
	ScrollingFrame.BackgroundColor3 = Color3.new(1, 1, 1)
	ScrollingFrame.BackgroundTransparency = 1
	ScrollingFrame.BorderColor3 = Color3.new(0, 0, 0)
	ScrollingFrame.BorderSizePixel = 0
	ScrollingFrame.Position = UDim2.new(0,0,0,0)
	ScrollingFrame.Size = UDim2.new(1, 0, 1, 0)
	ScrollingFrame.CanvasSize = UDim2.new(0, 0, 1, 0)
	ScrollingFrame.ScrollBarThickness = 0
	ScrollingFrame.ScrollBarImageTransparency = 1
	ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
	ScrollingFrame.ClipsDescendants = true
	Sidebar.ClipsDescendants = true

	UIListLayout.Parent = ScrollingFrame
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

	AccountSec.Name = "AccountSec"
	AccountSec.Parent = Sidebar
	AccountSec.AnchorPoint = Vector2.new(0.5, 1)
	AccountSec.BackgroundColor3 = Color3.new(0.0980392, 0.0980392, 0.0980392)
	AccountSec.BorderColor3 = Color3.new(0.0980392, 0.0980392, 0.0980392)
	AccountSec.BorderSizePixel = 0
	AccountSec.Position = UDim2.new(0.5, 0, 0.949999869, 0)
	AccountSec.Size = UDim2.new(0.850000024, 0, 0.113884628, 0)

	UICorner_5.Parent = AccountSec

	ImageLabel_2.Parent = AccountSec
	ImageLabel_2.AnchorPoint = Vector2.new(0, 0.5)
	ImageLabel_2.BackgroundColor3 = Color3.new(1, 1, 1)
	ImageLabel_2.BorderColor3 = Color3.new(0, 0, 0)
	ImageLabel_2.BorderSizePixel = 0
	ImageLabel_2.Position = UDim2.new(0.0500000007, 0, 0.5, 0)
	ImageLabel_2.Size = UDim2.new(0.850000024, 0, 0.850000024, 0)
	ImageLabel_2.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"

	task.spawn(function()
		local PlayerAvatar
		local Success, Error = pcall(function()
			PlayerAvatar = game.Players:GetUserThumbnailAsync(game.Players.LocalPlayer.UserId, Enum.ThumbnailType.AvatarBust, Enum.ThumbnailSize.Size180x180)
		end)
		if PlayerAvatar then
			ImageLabel_2.Image = PlayerAvatar
			ImageLabel_2.BackgroundColor3 = Color3.fromRGB(30,30,30)
		end
	end)

	UICorner_6.Parent = ImageLabel_2
	UICorner_6.CornerRadius = UDim.new(1, 0)

	UIAspectRatioConstraint_2.Parent = ImageLabel_2

	TextLabel.Parent = AccountSec
	TextLabel.AnchorPoint = Vector2.new(0.5, 0)
	TextLabel.BackgroundColor3 = Color3.new(1, 1, 1)
	TextLabel.BackgroundTransparency = 1
	TextLabel.BorderColor3 = Color3.new(0, 0, 0)
	TextLabel.BorderSizePixel = 0
	TextLabel.Position = UDim2.new(0.641402841, 0, -0.0104878535, 0)
	TextLabel.Size = UDim2.new(0.571309447, 0, 0.429874241, 0)
	TextLabel.Font = Enum.Font.FredokaOne
	TextLabel.Text = game.Players.LocalPlayer.DisplayName
	TextLabel.TextColor3 = Color3.new(1, 1, 1)
	TextLabel.TextScaled = true
	TextLabel.TextSize = 14
	TextLabel.TextWrapped = true

	TextLabel_2.Parent = AccountSec
	TextLabel_2.AnchorPoint = Vector2.new(0.5, 0)
	TextLabel_2.BackgroundColor3 = Color3.new(1, 1, 1)
	TextLabel_2.BackgroundTransparency = 1
	TextLabel_2.BorderColor3 = Color3.new(0, 0, 0)
	TextLabel_2.BorderSizePixel = 0
	TextLabel_2.Position = UDim2.new(0.641402841, 0, 0.418826312, 0)
	TextLabel_2.Size = UDim2.new(0.571309447, 0, 0.429874241, 0)
	TextLabel_2.Font = Enum.Font.FredokaOne
	TextLabel_2.Text = "Owner"
	TextLabel_2.TextColor3 = Color3.new(0, 0.607843, 1)
	TextLabel_2.TextScaled = true
	TextLabel_2.TextSize = 14
	TextLabel_2.TextWrapped = true

	MainSection.Name = "MainSection"
	MainSection.Parent = Frame
	MainSection.BackgroundColor3 = Color3.new(1, 1, 1)
	MainSection.BackgroundTransparency = 1
	MainSection.BorderColor3 = Color3.new(0, 0, 0)
	MainSection.BorderSizePixel = 0
	MainSection.Position = UDim2.new(0.236981466, 0, 0.0263559967, 0)
	MainSection.Size = UDim2.new(0.750661969, 0, 0.95225364, 0)

	function Window:CreateTab(tabTitle)
		local Tab = {
			title = tabTitle,
			sections = {}
		}

		local NewPage = Instance.new("ScrollingFrame")
		local UIListLayout = Instance.new("UIListLayout")

		NewPage.Name = "NewPage"
		NewPage.Parent = MainSection
		NewPage.Active = true
		NewPage.BackgroundColor3 = Color3.new(1, 1, 1)
		NewPage.BackgroundTransparency = 1 -- Research
		NewPage.BorderColor3 = Color3.new(0, 0, 0)
		NewPage.BorderSizePixel = 0
		NewPage.Size = NewPageSize
		NewPage.CanvasSize = UDim2.new(0, 0, 1, 0)
		NewPage.ScrollBarThickness = 0
		NewPage.ScrollBarImageTransparency = 1
		NewPage.AutomaticCanvasSize = Enum.AutomaticSize.Y
		NewPage.Visible = false
		Tab.Page = NewPage

		UIListLayout.Parent = NewPage
		UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.Padding = UDim.new(0.0149999997, 0)


		local TabButton = Instance.new("Frame")
		local TextLabel = Instance.new("TextLabel")

		TabButton.Name = "TabButton"
		TabButton.Parent = ScrollingFrame
		TabButton.BackgroundColor3 = Color3.new(0, 0.607843, 1)
		TabButton.BorderColor3 = Color3.new(0, 0, 0)
		TabButton.BorderSizePixel = 0
		TabButton.Size = UDim2.new(1, 0, 0.25, 0)
		TabButton.Transparency = 1

		TextLabel.Parent = TabButton
		TextLabel.AnchorPoint = Vector2.new(0.5, .5)
		TextLabel.BackgroundColor3 = Color3.new(1, 1, 1)
		TextLabel.BackgroundTransparency = 1
		TextLabel.BorderColor3 = Color3.new(0, 0, 0)
		TextLabel.BorderSizePixel = 0
		TextLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
		TextLabel.Size = UDim2.new(0.75000006, 0, 0.425, 0)
		TextLabel.Font = Enum.Font.FredokaOne
		TextLabel.Text = tabTitle
		TextLabel.TextColor3 = Color3.new(1, 1, 1)
		TextLabel.TextScaled = true
		TextLabel.TextSize = 14
		TextLabel.TextWrapped = true
		Tab.Button = TabButton

		TabButton.InputBegan:Connect(function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 and Input.UserInputState == Enum.UserInputState.Begin then
				for i,v in pairs(Window.tabs) do
					v.Page.Visible = false
					v.Button.Transparency = 1
				end

				selectedButton=TabButton
				NewPage.Visible = true
				TabButton.Transparency = 0
			end
		end)
		TabButton.MouseEnter:Connect(function()
			TabButton.Transparency = 0
		end)
		TabButton.MouseLeave:Connect(function()
			if not (TabButton==selectedButton) then
				TabButton.Transparency = 1
			end
		end)

		function Tab:Label(LabelText, Custom)
			
			local Custom = Custom or {}
			local Label = {}
			local AL = Enum.TextXAlignment.Left
			if Custom.Allignment then AL = Custom.Allignment end

			local LabelFrame = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local Title = Instance.new("TextLabel")
			local UIPadding = Instance.new("UIPadding")

			LabelFrame.Name = "LabelFrame"
			LabelFrame.Parent = NewPage
			LabelFrame.AnchorPoint = Vector2.new(0.5, 0)
			LabelFrame.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
			LabelFrame.BorderColor3 = Color3.new(0.117647, 0.117647, 0.117647)
			LabelFrame.BorderSizePixel = 0
			LabelFrame.Position = UDim2.new(0.5, 0, 0.720000029, 0)
			LabelFrame.Size = Section_LabelSize

			UICorner.Parent = LabelFrame
			UICorner.CornerRadius = UDim.new(0, 5)

			Title.Name = "Title"
			Title.Parent = LabelFrame
			Title.AnchorPoint = Vector2.new(0.5, 0.5)
			Title.BackgroundColor3 = Color3.new(1, 1, 1)
			Title.BackgroundTransparency = 1
			Title.BorderColor3 = Color3.new(0, 0, 0)
			Title.BorderSizePixel = 0
			Title.Position = UDim2.new(0.5, 0, 0.5, 0)
			Title.Size = UDim2.new(1, 0, 0.600000024, 0)
			Title.Font = Enum.Font.FredokaOne
			Title.Text = LabelText
			Title.TextColor3 = Custom.Color or Color3.new(0.686275, 0.686275, 0.686275)
			Title.TextScaled = true
			Title.TextSize = 14
			Title.TextWrapped = true
			Title.TextXAlignment = AL

			UIPadding.Parent = Title
			UIPadding.PaddingLeft = UDim.new(0.0500000007, 0)
			UIPadding.PaddingRight = UDim.new(0.0500000007, 0)

			function Label:Destroy()
				LabelFrame:Destroy()
			end
			Label.Frame = LabelFrame
			return Label

		end
		function Tab:Credit(Title)
			return Tab:Label(Title)
		end


		function Tab:Section(sectionTitle)
			local Section = {
				title = sectionTitle,
				elements = {}
			}

			local DropDown = Instance.new("Frame")
			local UIListLayout = Instance.new("UIListLayout")
			local dropdownMain = Instance.new("Frame")
			local dropdownArrow = Instance.new("TextLabel")
			local dropdownTitle = Instance.new("TextLabel")
			local UICorner = Instance.new("UICorner")
			local UICorner_2 = Instance.new("UICorner")

			DropDown.Name = "DropDown"
			DropDown.Parent = NewPage
			DropDown.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
			DropDown.BorderColor3 = Color3.new(0, 0, 0)
			DropDown.BorderSizePixel = 0
			DropDown.ClipsDescendants = true
			DropDown.Position = UDim2.new(0.0638888925, 0, -0.612167299, 0)
			DropDown.Size = BaseSection_Size
			DropDown.ClipsDescendants = true

			table.insert(dropdownFrames, DropDown)

			UIListLayout.Parent = DropDown
			UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.Padding = UDim.new(0, 5)

			dropdownMain.Name = "dropdownMain"
			dropdownMain.Parent = DropDown
			dropdownMain.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
			dropdownMain.BorderColor3 = Color3.new(0, 0, 0)
			dropdownMain.BorderSizePixel = 0
			dropdownMain.LayoutOrder = -1
			dropdownMain.Position = UDim2.new(0.0352065153, 0, 0, 0)
			--dropdownMain.Size = UDim2.new(0, 302, 0, 40)
			dropdownMain.Size = BaseSection_Size

			dropdownArrow.Name = "dropdownArrow"
			dropdownArrow.Parent = dropdownMain
			dropdownArrow.AnchorPoint = Vector2.new(0.5, 0)
			dropdownArrow.BackgroundColor3 = Color3.new(1, 1, 1)
			dropdownArrow.BackgroundTransparency = 1
			dropdownArrow.BorderColor3 = Color3.new(0, 0, 0)
			dropdownArrow.BorderSizePixel = 0
			dropdownArrow.Position = UDim2.new(0.942646146, 0, 0.34018153, 0)
			dropdownArrow.Size = UDim2.new(0, 10, 0, 12)
			dropdownArrow.Font = Enum.Font.FredokaOne
			dropdownArrow.Text = "V"
			dropdownArrow.TextColor3 = Color3.new(0.784314, 0.784314, 0.784314)
			dropdownArrow.TextScaled = true
			dropdownArrow.TextSize = 14
			dropdownArrow.TextWrapped = true
			dropdownArrow.TextXAlignment = Enum.TextXAlignment.Left

			dropdownTitle.Name = "dropdownTitle"
			dropdownTitle.Parent = dropdownMain
			dropdownTitle.AnchorPoint = Vector2.new(0.5, 0.5)
			dropdownTitle.BackgroundColor3 = Color3.new(1, 1, 1)
			dropdownTitle.BackgroundTransparency = 1
			dropdownTitle.BorderColor3 = Color3.new(0, 0, 0)
			dropdownTitle.BorderSizePixel = 0
			dropdownTitle.Position = UDim2.new(0.403059602, 0, 0.5, 0)
			dropdownTitle.Size = UDim2.new(0, 226, 0, 16)
			dropdownTitle.Font = Enum.Font.FredokaOne
			dropdownTitle.Text = sectionTitle
			dropdownTitle.TextColor3 = Color3.new(0.784314, 0.784314, 0.784314)
			dropdownTitle.TextScaled = true
			dropdownTitle.TextSize = 14
			dropdownTitle.TextWrapped = true
			dropdownTitle.TextXAlignment = Enum.TextXAlignment.Left

			UICorner.Parent = dropdownMain

			UICorner_2.Parent = DropDown

			local Button = Instance.new("ImageButton")
			Button.Parent = dropdownMain
			Button.Image = ""
			Button.ImageTransparency = 1
			Button.BackgroundTransparency = 1
			Button.Size = UDim2.new(1,0,1,0)

			local sectionIsOpen = false
			local DB = false
		
			Button.MouseButton1Click:Connect(function()
				if not DB then

					DB = true
					if sectionIsOpen then
						sectionIsOpen = false
						DropDown:TweenSize(
							
							UDim2.new(0, DropDown.Size.X.Offset, 0, dropdownMain.Size.Y.Offset),
							Enum.EasingDirection.Out,
							Enum.EasingStyle.Sine,
							.1,
							true,
							function()
								DropDown.BackgroundTransparency = 1
								DB=false
							end
						)
						game.TweenService:Create(dropdownArrow, TweenInfo.new(.1), {Rotation=0}):Play()
					else
						sectionIsOpen = true
						DropDown.BackgroundTransparency = 0
						DropDown:TweenSize(
							UDim2.new(0, DropDown.Size.X.Offset, 0, CalculateSize(DropDown, UIListLayout, Scaleable.Scale)),
							--UDim2.new(0, DropDown.Size.X.Offset, 0, UIListLayout.AbsoluteContentSize.Y+10),
							Enum.EasingDirection.Out,
							Enum.EasingStyle.Sine,
							.1,
							true,
							function()
								DB=false
							end
						)
						game.TweenService:Create(dropdownArrow, TweenInfo.new(.1), {Rotation=180}):Play()
					end
				end
			end)

			function Section:BlankSpace(CustomSize)
				local size = CustomSize or 10
				local X = Instance.new("Frame", DropDown)
				X.Transparency = 1
				X.Size = UDim2.new(1,0,0,size)
			end
			
			function Section:Credit(Title)
				return Section:Label(Title)
			end
			
			function Section:DropDown(placeholderTitle, ItemList, callback)
				local Dropdown = {
					title = placeholderTitle,
					elements = {}
				}
				local ItemList = ItemList or {}

				local NestedDropDown = Instance.new("Frame")
				local NestedUIListLayout = Instance.new("UIListLayout")
				local NestedDropdownMain = Instance.new("Frame")
				local NestedDropdownArrow = Instance.new("TextLabel")
				local NestedDropdownTitle = Instance.new("TextLabel")
				local NestedUICorner = Instance.new("UICorner")
				local NestedUICorner_2 = Instance.new("UICorner")

				NestedDropDown.Name = "DropDown"
				NestedDropDown.Parent = DropDown
				NestedDropDown.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
				NestedDropDown.BorderColor3 = Color3.new(0, 0, 0)
				NestedDropDown.BorderSizePixel = 0
				NestedDropDown.Position = UDim2.new(0.0638888925, 0, -0.612167299, 0)
				NestedDropDown.Size = UDim2.new(0,BaseSection_Size.X.Offset,0,25)
				NestedDropDown.ClipsDescendants = true

				table.insert(dropdownFrames, NestedDropDown)

				NestedUIListLayout.Parent = NestedDropDown
				NestedUIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
				NestedUIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
				NestedUIListLayout.Padding = UDim.new(0, 5)

				NestedDropdownMain.Name = "NestedDropdownMain"
				NestedDropdownMain.Parent = NestedDropDown
				--NestedDropdownMain.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
				NestedDropdownMain.BackgroundColor3 = Color3.new(0.156863, 0.156863, 0.156863)
				NestedDropdownMain.BorderColor3 = Color3.new(0, 0, 0)
				NestedDropdownMain.BorderSizePixel = 0
				NestedDropdownMain.LayoutOrder = -1
				NestedDropdownMain.Position = UDim2.new(0.0352065153, 0, 0, 0)
				NestedDropdownMain.Size = UDim2.new(0, 290, 0, 25)

				NestedDropdownArrow.Name = "NestedDropdownArrow"
				NestedDropdownArrow.Parent = NestedDropdownMain
				NestedDropdownArrow.AnchorPoint = Vector2.new(0.5, 0)
				NestedDropdownArrow.BackgroundColor3 = Color3.new(1, 1, 1)
				NestedDropdownArrow.BackgroundTransparency = 1
				NestedDropdownArrow.BorderColor3 = Color3.new(0, 0, 0)
				NestedDropdownArrow.BorderSizePixel = 0
				NestedDropdownArrow.Position = UDim2.new(0.942646146, 0, 0.34018153, 0)
				NestedDropdownArrow.Size = UDim2.new(0, 10, 0, 12)
				NestedDropdownArrow.Font = Enum.Font.FredokaOne
				NestedDropdownArrow.Text = "V"
				NestedDropdownArrow.TextColor3 = Color3.new(0.784314, 0.784314, 0.784314)
				NestedDropdownArrow.TextScaled = true
				NestedDropdownArrow.TextSize = 14
				NestedDropdownArrow.TextWrapped = true
				NestedDropdownArrow.TextXAlignment = Enum.TextXAlignment.Left

				NestedDropdownTitle.Name = "NestedDropdownTitle"
				NestedDropdownTitle.Parent = NestedDropdownMain
				NestedDropdownTitle.AnchorPoint = Vector2.new(0.5, 0.5)
				NestedDropdownTitle.BackgroundColor3 = Color3.new(1, 1, 1)
				NestedDropdownTitle.BackgroundTransparency = 1
				NestedDropdownTitle.BorderColor3 = Color3.new(0, 0, 0)
				NestedDropdownTitle.BorderSizePixel = 0
				NestedDropdownTitle.Position = UDim2.new(0.425, 0, 0.5, 0)
				NestedDropdownTitle.Size = UDim2.new(0, 226, 0, 16)
				NestedDropdownTitle.Font = Enum.Font.FredokaOne
				NestedDropdownTitle.Text = placeholderTitle or "Dropdown"
				NestedDropdownTitle.TextColor3 = Color3.new(0.784314, 0.784314, 0.784314)
				NestedDropdownTitle.TextScaled = true
				NestedDropdownTitle.TextSize = 14
				NestedDropdownTitle.TextWrapped = true
				NestedDropdownTitle.TextXAlignment = Enum.TextXAlignment.Left

				NestedUICorner.Parent = NestedDropdownMain

				NestedUICorner_2.Parent = NestedDropDown

				local Button = Instance.new("ImageButton")
				Button.Parent = NestedDropdownMain
				Button.Image = ""
				Button.ImageTransparency = 1
				Button.BackgroundTransparency = 1
				Button.Size = UDim2.new(1,0,1,0)

				local sectionIsOpen = false
				local DB = false
				

				local function updateParentSize()
					if sectionIsOpen then
						NestedDropDown.Size = UDim2.new(0, NestedDropDown.Size.X.Offset, 0, CalculateSize(NestedDropDown, NestedUIListLayout, Scaleable.Scale))--/Scaleable.Scale)
					else
						NestedDropDown.Size = UDim2.new(0, NestedDropDown.Size.X.Offset, 0, NestedDropdownMain.Size.Y.Offset)
					end
				end

				local function UpdateParentSize()
					DropDown:TweenSize(
						UDim2.new(0, DropDown.Size.X.Offset, 0, CalculateSize(DropDown, UIListLayout, Scaleable.Scale)),--/Scaleable.Scale),
						Enum.EasingDirection.Out,
						Enum.EasingStyle.Sine,
						.1,
						true,
						function()
							DB=false
						end
					)
				end

				Button.MouseButton1Click:Connect(function()
					if not DB then

						DB = true
						if sectionIsOpen then
							sectionIsOpen = false
							NestedDropDown:TweenSize(
								UDim2.new(0, NestedDropDown.Size.X.Offset, 0, NestedDropdownMain.Size.Y.Offset),
								Enum.EasingDirection.Out,
								Enum.EasingStyle.Sine,
								.1,
								true,
								function()
									NestedDropDown.BackgroundTransparency = 1
									UpdateParentSize()
								end
							)
							game.TweenService:Create(NestedDropdownArrow, TweenInfo.new(.1), {Rotation=0}):Play()
						else
							sectionIsOpen = true
							NestedDropDown.BackgroundTransparency = 0
							NestedDropDown:TweenSize(
								--UDim2.new(0, NestedDropDown.Size.X.Offset, 0, NestedUIListLayout.AbsoluteContentSize.Y+10),--/Scaleable.Scale),
								UDim2.new(0, NestedDropDown.Size.X.Offset, 0, CalculateSize(NestedDropDown, NestedUIListLayout, Scaleable.Scale)),								
								Enum.EasingDirection.Out,
								Enum.EasingStyle.Sine,
								.1,
								true,
								function()
									UpdateParentSize()
								end
							)

							game.TweenService:Create(NestedDropdownArrow, TweenInfo.new(.1), {Rotation=180}):Play()
						end
					end
				end)

				for i,v in pairs(ItemList) do
					local ButtonText = "Select"
					local Toggle = Instance.new("Frame")
					local UICorner = Instance.new("UICorner")
					local Title = Instance.new("TextLabel")
					local Frame = Instance.new("Frame")
					local UICorner_2 = Instance.new("UICorner")
					local TextLabel = Instance.new("TextLabel")

					Toggle.Name = "Toggle"
					Toggle.Parent = NestedDropDown
					Toggle.AnchorPoint = Vector2.new(0.5, 0)
					Toggle.BackgroundColor3 = Color3.new(0.156863, 0.156863, 0.156863)
					Toggle.BorderColor3 = Color3.new(0.137255, 0.137255, 0.137255)
					Toggle.BorderSizePixel = 0
					Toggle.Position = UDim2.new(0.5, 0, 0, 0)
					Toggle.Size = BaseItemSize_Nested

					UICorner.Parent = Toggle

					Title.Name = "Title"
					Title.Parent = Toggle
					Title.AnchorPoint = Vector2.new(0.5, 0)
					Title.BackgroundColor3 = Color3.new(1, 1, 1)
					Title.BackgroundTransparency = 1
					Title.BorderColor3 = Color3.new(0, 0, 0)
					Title.BorderSizePixel = 0
					Title.Position = UDim2.new(0.35952127, 0, 0.316090286, 0)
					Title.Size = UDim2.new(0.667221844, 0, 0.55, 0)
					Title.Font = Enum.Font.FredokaOne
					Title.Text = v
					Title.TextColor3 = Color3.new(0.686275, 0.686275, 0.686275)
					Title.TextScaled = true
					Title.TextSize = 14
					Title.TextWrapped = true
					Title.TextXAlignment = Enum.TextXAlignment.Left

					Frame.Parent = Toggle
					Frame.AnchorPoint = Vector2.new(1, 0.5)
					Frame.BackgroundColor3 = Color3.new(0.156863, 0.156863, 0.156863)
					Frame.BorderColor3 = Color3.new(0, 0, 0)
					Frame.BorderSizePixel = 0
					Frame.Position = UDim2.new(0.97999984, 0, 0.5, 0)
					Frame.Size = UDim2.new(0.271149337, 0, 0.75, 0)

					UICorner_2.Parent = Frame

					TextLabel.Parent = Frame
					TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
					TextLabel.BackgroundColor3 = Color3.new(1, 1, 1)
					TextLabel.BackgroundTransparency = 1
					TextLabel.BorderColor3 = Color3.new(0, 0, 0)
					TextLabel.BorderSizePixel = 0
					TextLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
					TextLabel.Size = UDim2.new(1, 0, 0.5, 0)
					TextLabel.Font = Enum.Font.FredokaOne
					TextLabel.Text = ButtonText
					TextLabel.TextColor3 = Color3.new(0.686275, 0.686275, 0.686275)
					TextLabel.TextSize = 14

					local UIStroke = Instance.new("UIStroke", Frame)
					UIStroke.Color = Color3.fromRGB(50,50,50)

					local TweenTime = 0.05
					local Debounce = false
					local isHovering = false
					
					Frame.MouseEnter:Connect(function()
						isHovering = true
						game.TweenService:Create(UIStroke, TweenInfo.new(TweenTime), {Color=Color3.fromRGB(0,155,255)}):Play()
					end)
					Frame.MouseLeave:Connect(function()
						isHovering = false
						game.TweenService:Create(UIStroke, TweenInfo.new(TweenTime), {Color=Color3.fromRGB(50,50,50)}):Play()
					end)
					
					Frame.InputBegan:Connect(function(Input)
						if Input.UserInputType == Enum.UserInputType.MouseButton1 and Input.UserInputState == Enum.UserInputState.Begin and (not Debounce) then		
							Debounce = true
							callback()
							game.TweenService:Create(UIStroke, TweenInfo.new(TweenTime), {Color=Color3.fromRGB(0,155,255)}):Play()
							Frame:TweenSize(
								UDim2.new(0.271149337*Mult, 0, 0.75*Mult, 0),
								Enum.EasingDirection.Out,
								Enum.EasingStyle.Sine,
								TweenTime,
								false,
								function()
									if not isHovering then
										game.TweenService:Create(UIStroke, TweenInfo.new(TweenTime), {Color=Color3.fromRGB(50,50,50)}):Play()
									end
									Frame:TweenSize(
										UDim2.new(0.271149337, 0, 0.75, 0),
										Enum.EasingDirection.Out,
										Enum.EasingStyle.Sine,
										TweenTime
									)
								end
							)
							sectionIsOpen = false
							NestedDropDown:TweenSize(
								UDim2.new(0, NestedDropDown.Size.X.Offset, 0, NestedDropdownMain.Size.Y.Offset),
								Enum.EasingDirection.Out,
								Enum.EasingStyle.Sine,
								.1,
								true,
								function()
									NestedDropDown.BackgroundTransparency = 1
									UpdateParentSize()
								end
							)
							NestedDropdownTitle.Text = placeholderTitle..": "..v
							game.TweenService:Create(NestedDropdownArrow, TweenInfo.new(.1), {Rotation=0}):Play()
							task.delay(TweenTime*2, function()
								Debounce = false
							end)
							callback(v)
						end
					end)
				end

				return Dropdown
			end

			function Section:Label(LabelText, Custom)

				local Custom = Custom or {}
				local Label = {}
				local AL = Enum.TextXAlignment.Left
				if Custom.Allignment then AL = Custom.Allignment end

				local LabelFrame = Instance.new("Frame")
				local UICorner = Instance.new("UICorner")
				local Title = Instance.new("TextLabel")
				local UIPadding = Instance.new("UIPadding")

				LabelFrame.Name = "LabelFrame"
				LabelFrame.Parent = DropDown
				LabelFrame.AnchorPoint = Vector2.new(0.5, 0)
				LabelFrame.BackgroundColor3 = Color3.new(0.156863, 0.156863, 0.156863)
				LabelFrame.BorderColor3 = Color3.new(0.137255, 0.137255, 0.137255)
				LabelFrame.BorderSizePixel = 0
				LabelFrame.Position = UDim2.new(0.5, 0, 0.720000029, 0)
				LabelFrame.Size = Section_MainLabelSize

				UICorner.Parent = LabelFrame
				UICorner.CornerRadius = UDim.new(0, 5)

				Title.Name = "Title"
				Title.Parent = LabelFrame
				Title.AnchorPoint = Vector2.new(0.5, 0.5)
				Title.BackgroundColor3 = Color3.new(1, 1, 1)
				Title.BackgroundTransparency = 1
				Title.BorderColor3 = Color3.new(0, 0, 0)
				Title.BorderSizePixel = 0
				Title.Position = UDim2.new(0.5, 0, 0.5, 0)
				Title.Size = UDim2.new(1, 0, 0.600000024, 0)
				Title.Font = Enum.Font.FredokaOne
				Title.Text = LabelText
				Title.TextColor3 = Custom.Color or Color3.new(0.686275, 0.686275, 0.686275)
				Title.TextScaled = true
				Title.TextSize = 14
				Title.TextWrapped = true
				Title.TextXAlignment = AL

				UIPadding.Parent = Title
				UIPadding.PaddingLeft = UDim.new(0.0500000007, 0)
				UIPadding.PaddingRight = UDim.new(0.0500000007, 0)

				function Label:Destroy()
					LabelFrame:Destroy()
				end
				Label.Frame = LabelFrame
				return Label

			end

			function Section:Slider(SliderTitle, MinVal, MaxVal, callback, Extra)
				local Extra = Extra or {}

				local Slider = Instance.new("Frame")
				local UICorner = Instance.new("UICorner")
				local Title = Instance.new("TextLabel")
				local Frame = Instance.new("Frame")
				local UICorner_2 = Instance.new("UICorner")
				local Frame_2 = Instance.new("Frame")
				local UICorner_3 = Instance.new("UICorner")
				local Pointer = Instance.new("Frame")
				local Arrow = Instance.new("Frame")
				local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
				local UICorner_4 = Instance.new("UICorner")
				local Main = Instance.new("Frame")
				local UICorner_5 = Instance.new("UICorner")
				local TextLabel = Instance.new("TextLabel")

				Slider.Name = "Slider"
				Slider.Parent = DropDown
				Slider.AnchorPoint = Vector2.new(0.5, 0)
				Slider.BackgroundColor3 = Color3.new(0.176471, 0.176471, 0.176471)
				Slider.BorderColor3 = Color3.new(0.137255, 0.137255, 0.137255)
				Slider.BorderSizePixel = 0
				Slider.Position = UDim2.new(0.44607842, 0, 0.540000021, 0)
				Slider.Size = BaseItemSize_Section

				UICorner.Parent = Slider

				Title.Name = "Title"
				Title.Parent = Slider
				Title.AnchorPoint = Vector2.new(0.5, 0)
				Title.BackgroundColor3 = Color3.new(1, 1, 1)
				Title.BackgroundTransparency = 1
				Title.BorderColor3 = Color3.new(0, 0, 0)
				Title.BorderSizePixel = 0
				Title.Position = UDim2.new(0.257265508, 0, 0.316090405, 0)
				Title.Size = UDim2.new(0.462710351, 0, 0.354564667, 0)
				Title.Font = Enum.Font.FredokaOne
				Title.Text = SliderTitle
				Title.TextColor3 = Color3.new(0.686275, 0.686275, 0.686275)
				Title.TextScaled = true
				Title.TextSize = 14
				Title.TextWrapped = true
				Title.TextXAlignment = Enum.TextXAlignment.Left

				Frame.Parent = Slider
				Frame.AnchorPoint = Vector2.new(1, 0.5)
				Frame.BackgroundColor3 = Color3.new(0.156863, 0.156863, 0.156863)
				Frame.BorderColor3 = Color3.new(0, 0, 0)
				Frame.BorderSizePixel = 0
				Frame.Position = UDim2.new(0.980000019, 0, 0.491577536, 0)
				--Frame.Size = UDim2.new(0.487930983, 0, 0.283155054, 0)
				Frame.Size = UDim2.new(0.487930983, 0, 0.5, 0)

				UICorner_2.Parent = Frame

				Frame_2.Parent = Frame
				Frame_2.AnchorPoint = Vector2.new(0, 0.5)
				Frame_2.BackgroundColor3 = Color3.new(0.784314, 0.784314, 0.784314)
				Frame_2.BorderColor3 = Color3.new(0, 0, 0)
				Frame_2.BorderSizePixel = 0
				Frame_2.Position = UDim2.new(0, 0, 0.5, 0)
				Frame_2.Size = UDim2.new(0, 0, 1, 0)

				UICorner_3.Parent = Frame_2

				Pointer.Name = "Pointer"
				Pointer.Parent = Frame_2
				Pointer.AnchorPoint = Vector2.new(0.5, 1)
				Pointer.BackgroundColor3 = Color3.new(1, 1, 1)
				Pointer.BackgroundTransparency = 1
				Pointer.BorderColor3 = Color3.new(0, 0, 0)
				Pointer.BorderSizePixel = 0
				Pointer.Position = UDim2.new(1.01999998, 0, -1.8524157e-05, 0)
				Pointer.Size = UDim2.new(0, 0, 0, 0)
				Pointer.Visible = false

				Arrow.Name = "Arrow"
				Arrow.Parent = Pointer
				Arrow.BackgroundColor3 = Color3.new(0.196078, 0.196078, 0.196078)
				Arrow.BorderColor3 = Color3.new(0, 0, 0)
				Arrow.BorderSizePixel = 0
				Arrow.Position = UDim2.new(0.19005616, 0, 0.523908794, 0)
				Arrow.Rotation = 45
				Arrow.Size = UDim2.new(0.44384104, 0, 0.573330164, 0)

				UIAspectRatioConstraint.Parent = Arrow

				UICorner_4.Parent = Arrow
				UICorner_4.CornerRadius = UDim.new(0, 2)

				Main.Name = "Main"
				Main.Parent = Pointer
				Main.BackgroundColor3 = Color3.new(0.196078, 0.196078, 0.196078)
				Main.BorderColor3 = Color3.new(0, 0, 0)
				Main.BorderSizePixel = 0
				Main.Position = UDim2.new(-0.100574739, 0, 0.325616956, 0)
				Main.Size = UDim2.new(1, 0, 0.621141613, 0)

				UICorner_5.Parent = Main
				UICorner_5.CornerRadius = UDim.new(0, 4)

				TextLabel.Parent = Main
				TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
				TextLabel.BackgroundColor3 = Color3.new(1, 1, 1)
				TextLabel.BackgroundTransparency = 1
				TextLabel.BorderColor3 = Color3.new(0, 0, 0)
				TextLabel.BorderSizePixel = 0
				TextLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
				TextLabel.Size = UDim2.new(0.800000012, 0, 0.900000012, 0)
				TextLabel.Font = Enum.Font.FredokaOne
				TextLabel.Text = "0/0"
				TextLabel.TextColor3 = Color3.new(1, 1, 1)
				TextLabel.TextScaled = true
				TextLabel.TextSize = 14
				TextLabel.TextWrapped = true

				local Gradient = Instance.new("UIGradient")
				Gradient.Transparency = NumberSequence.new({
					NumberSequenceKeypoint.new(0,0),
					NumberSequenceKeypoint.new(1,1)
				})
				Gradient.Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0,Color3.fromRGB(0,155,255)),
					ColorSequenceKeypoint.new(1,Color3.fromRGB(40,40,40))
				})
				Gradient.Rotation = 180
				Gradient.Parent = Frame_2

				local Mouse = game.Players.LocalPlayer:GetMouse()

				local O = 0
				local N = MinVal
				if MinVal < 1 then
					repeat task.wait()
						N = N*10
						O = O + 1
					until N >= 1
				end

				local lastInput = 0
				local Qd = false
				local function QueueClosure()
					Qd = true
					task.spawn(function()
						repeat task.wait() until (tick()-(lastInput+1))>0
						Pointer:TweenSize(
							UDim2.new(0,0,0,0),
							Enum.EasingDirection.Out,
							Enum.EasingStyle.Sine,
							0.1,
							false,function()
								Pointer.Visible = false
								Qd = false
							end
						)
					end)
				end


				local function CalculateMath()
					local Diff = Mouse.X - Frame.AbsolutePosition.X
					if Diff < 0 then Diff = 0 end
					local Math = Diff / Frame.AbsoluteSize.X
					if Math > 1 then Math = 1 end
					local Value = tonumber(string.format("%." .. (O or 0) .. "f", (MaxVal*Math)))
					Frame_2.Size = UDim2.new(
						Math,0,
						1,0
					)
					if Value < MinVal then Value = MinVal end
					TextLabel.Text = tostring(Value).."/"..tostring(MaxVal)
					callback(Value)
				end

				Frame.InputBegan:Connect(function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseButton1 and Input.UserInputState == Enum.UserInputState.Begin then
						QueueClosure()
						isUsingSlider = true
						Pointer.Visible = true
						Pointer:TweenSize(
							UDim2.new(0, 30, 0, 20),
							Enum.EasingDirection.Out,
							Enum.EasingStyle.Sine,
							0.1,
							false
						)
						local Connection = Mouse.Move:Connect(function()
							lastInput = tick()
							CalculateMath()
						end);CalculateMath()
						
						Frame.InputEnded:Connect(function(Input)
							if Input.UserInputType == Enum.UserInputType.MouseButton1 then
								Connection:Disconnect()
								isUsingSlider = false
							end
						end)
					end
				end)



			end
			
			function Section:Code(InputTitle, callback, Extra) -- Experimental Function Lol
				local Extra = Extra or {}
				local Input = Instance.new("Frame")
				local UICorner = Instance.new("UICorner")
				local Title = Instance.new("TextLabel")
				local Frame = Instance.new("Frame")
				local UICorner_2 = Instance.new("UICorner")
				local TextBox = Instance.new("TextBox")
				local UIPadding = Instance.new("UIPadding")

				Input.Name = "Input"
				Input.Parent = DropDown
				Input.AnchorPoint = Vector2.new(0.5, 0)
				Input.BackgroundColor3 = Color3.new(0.156863, 0.156863, 0.156863)
				Input.BorderColor3 = Color3.new(0.137255, 0.137255, 0.137255)
				Input.BorderSizePixel = 0
				Input.Position = UDim2.new(0.473856211, 0, 0.560000002, 0)
				Input.Size = UDim2.new(
					0,BaseItemSize_Section.X.Offset,
					0,150
				)

				UICorner.Parent = Input

				Title.Name = "Title"
				Title.Parent = Input
				--Title.AnchorPoint = Vector2.new(0.5, 0)
				Title.BackgroundColor3 = Color3.new(1, 1, 1)
				Title.BackgroundTransparency = 1
				Title.BorderColor3 = Color3.new(0, 0, 0)
				Title.BorderSizePixel = 0
				Title.Position = UDim2.new(0.025, 0, 0.05, 0)
				Title.Size = UDim2.new(0.5, 0, 0.1, 0)
				Title.Font = Enum.Font.FredokaOne
				Title.Text = InputTitle
				Title.TextColor3 = Color3.new(0.686275, 0.686275, 0.686275)
				Title.TextScaled = true
				Title.TextSize = 14
				Title.TextWrapped = true
				Title.TextXAlignment = Enum.TextXAlignment.Left

				Frame.Parent = Input
				Frame.AnchorPoint = Vector2.new(.5, 0.5)
				Frame.BackgroundColor3 = Color3.new(0.156863, 0.156863, 0.156863)
				Frame.BorderColor3 = Color3.new(0, 0, 0)
				Frame.BorderSizePixel = 0
				Frame.Position = UDim2.new(0.5, 0, 0.55, 0)
				Frame.Size = UDim2.new(.95, 0, 0.75, 0)

				UICorner_2.Parent = Frame

				TextBox.Parent = Frame
				TextLabel.RichText = true
				TextBox.BackgroundColor3 = Color3.new(1, 1, 1)
				TextBox.BackgroundTransparency = 1
				TextBox.BorderColor3 = Color3.new(0, 0, 0)
				TextBox.BorderSizePixel = 0
				TextBox.Size = UDim2.new(1, 0, 1, 0)
				TextBox.Font = Enum.Font.FredokaOne
				TextBox.PlaceholderText = "Paste Scripts here:"
				TextBox.Text = ""
				TextBox.TextColor3 = Color3.new(1, 1, 1)
				TextBox.TextScaled = true
				TextBox.TextSize = 14
				TextBox.TextWrapped = true
				TextBox.TextXAlignment = Enum.TextXAlignment.Left
				TextBox.TextYAlignment = Enum.TextYAlignment.Top
				
				local Padding = Instance.new("UIPadding", TextBox)
				Padding.PaddingTop = UDim.new(.05,0)
				Padding.PaddingLeft = UDim.new(.05,0)
				
				local TextSizeConstrant = Instance.new("UITextSizeConstraint", TextBox)
				TextSizeConstrant.MaxTextSize = 16

				local Stroke = Instance.new("UIStroke", Frame)
				Stroke.Color = Color3.fromRGB(50,50,50)

				UIPadding.Parent = TextBox
				UIPadding.PaddingBottom = UDim.new(0.200000003, 0)
				UIPadding.PaddingLeft = UDim.new(0.200000003, 0)
				UIPadding.PaddingRight = UDim.new(0.200000003, 0)
				UIPadding.PaddingTop = UDim.new(0.200000003, 0)

				TextBox.FocusLost:Connect(function()
					if TextBox.Text ~= "" or Extra.AllowEmptyInput then
						callback(TextBox.Text)
						TextBox.Text = ""
					end
				end)
			end


			function Section:Input(InputTitle, callback, Extra)
				local Extra = Extra or {}
				local Input = Instance.new("Frame")
				local UICorner = Instance.new("UICorner")
				local Title = Instance.new("TextLabel")
				local Frame = Instance.new("Frame")
				local UICorner_2 = Instance.new("UICorner")
				local TextBox = Instance.new("TextBox")
				local UIPadding = Instance.new("UIPadding")

				Input.Name = "Input"
				Input.Parent = DropDown
				Input.AnchorPoint = Vector2.new(0.5, 0)
				Input.BackgroundColor3 = Color3.new(0.156863, 0.156863, 0.156863)
				Input.BorderColor3 = Color3.new(0.137255, 0.137255, 0.137255)
				Input.BorderSizePixel = 0
				Input.Position = UDim2.new(0.473856211, 0, 0.560000002, 0)
				Input.Size = BaseItemSize_Section

				UICorner.Parent = Input

				Title.Name = "Title"
				Title.Parent = Input
				Title.AnchorPoint = Vector2.new(0.5, 0)
				Title.BackgroundColor3 = Color3.new(1, 1, 1)
				Title.BackgroundTransparency = 1
				Title.BorderColor3 = Color3.new(0, 0, 0)
				Title.BorderSizePixel = 0
				Title.Position = UDim2.new(0.35952127, 0, 0.316090286, 0)
				Title.Size = UDim2.new(0.667221844, 0, 0.354564667, 0)
				Title.Font = Enum.Font.FredokaOne
				Title.Text = InputTitle
				Title.TextColor3 = Color3.new(0.686275, 0.686275, 0.686275)
				Title.TextScaled = true
				Title.TextSize = 14
				Title.TextWrapped = true
				Title.TextXAlignment = Enum.TextXAlignment.Left

				Frame.Parent = Input
				Frame.AnchorPoint = Vector2.new(1, 0.5)
				Frame.BackgroundColor3 = Color3.new(0.156863, 0.156863, 0.156863)
				Frame.BorderColor3 = Color3.new(0, 0, 0)
				Frame.BorderSizePixel = 0
				Frame.Position = UDim2.new(0.980000019, 0, 0.49782753, 0)
				Frame.Size = UDim2.new(0.208620682, 0, 0.545655072, 0)

				UICorner_2.Parent = Frame

				TextBox.Parent = Frame
				TextBox.BackgroundColor3 = Color3.new(1, 1, 1)
				TextBox.BackgroundTransparency = 1
				TextBox.BorderColor3 = Color3.new(0, 0, 0)
				TextBox.BorderSizePixel = 0
				TextBox.Size = UDim2.new(1, 0, 1, 0)
				TextBox.Font = Enum.Font.FredokaOne
				TextBox.PlaceholderText = "Placeholder"
				TextBox.Text = ""
				TextBox.TextColor3 = Color3.new(1, 1, 1)
				TextBox.TextScaled = true
				TextBox.TextSize = 14
				TextBox.TextWrapped = true
				
				local Stroke = Instance.new("UIStroke", Frame)
				Stroke.Color = Color3.fromRGB(50,50,50)

				UIPadding.Parent = TextBox
				UIPadding.PaddingBottom = UDim.new(0.200000003, 0)
				UIPadding.PaddingLeft = UDim.new(0.200000003, 0)
				UIPadding.PaddingRight = UDim.new(0.200000003, 0)
				UIPadding.PaddingTop = UDim.new(0.200000003, 0)

				TextBox.FocusLost:Connect(function()
					if TextBox.Text ~= "" or Extra.AllowEmptyInput then
						callback(TextBox.Text)
						TextBox.Text = ""
					end
				end)
			end

			function Section:Button(ButtonTitle, callback, ButtonText)
				local ButtonText = ButtonText or "Click"
				local Toggle = Instance.new("Frame")
				local UICorner = Instance.new("UICorner")
				local Title = Instance.new("TextLabel")
				local Frame = Instance.new("Frame")
				local UICorner_2 = Instance.new("UICorner")
				local TextLabel = Instance.new("TextLabel")

				Toggle.Name = "Toggle"
				Toggle.Parent = DropDown
				Toggle.AnchorPoint = Vector2.new(0.5, 0)
				Toggle.BackgroundColor3 = Color3.new(0.156863, 0.156863, 0.156863)
				Toggle.BorderColor3 = Color3.new(0.137255, 0.137255, 0.137255)
				Toggle.BorderSizePixel = 0
				Toggle.Position = UDim2.new(0.5, 0, 0, 0)
				Toggle.Size = BaseItemSize_Section

				UICorner.Parent = Toggle

				Title.Name = "Title"
				Title.Parent = Toggle
				Title.AnchorPoint = Vector2.new(0.5, 0)
				Title.BackgroundColor3 = Color3.new(1, 1, 1)
				Title.BackgroundTransparency = 1
				Title.BorderColor3 = Color3.new(0, 0, 0)
				Title.BorderSizePixel = 0
				Title.Position = UDim2.new(0.35952127, 0, 0.316090286, 0)
				Title.Size = UDim2.new(0.667221844, 0, 0.354564667, 0)
				Title.Font = Enum.Font.FredokaOne
				Title.Text = ButtonTitle
				Title.TextColor3 = Color3.new(0.686275, 0.686275, 0.686275)
				Title.TextScaled = true
				Title.TextSize = 14
				Title.TextWrapped = true
				Title.TextXAlignment = Enum.TextXAlignment.Left

				Frame.Parent = Toggle
				Frame.AnchorPoint = Vector2.new(1, 0.5)
				Frame.BackgroundColor3 = Color3.new(0.156863, 0.156863, 0.156863)
				Frame.BorderColor3 = Color3.new(0, 0, 0)
				Frame.BorderSizePixel = 0
				Frame.Position = UDim2.new(0.97999984, 0, 0.5, 0)
				Frame.Size = UDim2.new(0.271149337, 0, 0.75, 0)

				UICorner_2.Parent = Frame

				TextLabel.Parent = Frame
				TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
				TextLabel.BackgroundColor3 = Color3.new(1, 1, 1)
				TextLabel.BackgroundTransparency = 1
				TextLabel.BorderColor3 = Color3.new(0, 0, 0)
				TextLabel.BorderSizePixel = 0
				TextLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
				TextLabel.Size = UDim2.new(1, 0, 0.5, 0)
				TextLabel.Font = Enum.Font.FredokaOne
				TextLabel.Text = ButtonText
				TextLabel.TextColor3 = Color3.new(0.686275, 0.686275, 0.686275)
				TextLabel.TextSize = 14

				local UIStroke = Instance.new("UIStroke", Frame)
				UIStroke.Color = Color3.fromRGB(50,50,50)

				local TweenTime = 0.05
				local Debounce = false
				local isHovering = false
				
				Frame.MouseEnter:Connect(function()
					isHovering = true
					game.TweenService:Create(UIStroke, TweenInfo.new(TweenTime), {Color=Color3.fromRGB(0,155,255)}):Play()
				end)
				Frame.MouseLeave:Connect(function()
					isHovering = false
					game.TweenService:Create(UIStroke, TweenInfo.new(TweenTime), {Color=Color3.fromRGB(50,50,50)}):Play()
				end)
				
				Frame.InputBegan:Connect(function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseButton1 and Input.UserInputState == Enum.UserInputState.Begin and (not Debounce) then		
						Debounce = true
						callback()
						game.TweenService:Create(UIStroke, TweenInfo.new(TweenTime), {Color=Color3.fromRGB(0,155,255)}):Play()
						Frame:TweenSize(
							UDim2.new(0.271149337*Mult, 0, 0.75*Mult, 0),
							Enum.EasingDirection.Out,
							Enum.EasingStyle.Sine,
							TweenTime,
							false,
							function()
								if not isHovering then
									game.TweenService:Create(UIStroke, TweenInfo.new(TweenTime), {Color=Color3.fromRGB(50,50,50)}):Play()
								end
								Frame:TweenSize(
									UDim2.new(0.271149337, 0, 0.75, 0),
									Enum.EasingDirection.Out,
									Enum.EasingStyle.Sine,
									TweenTime
								)
							end
						)
						task.delay(TweenTime*2, function()
							Debounce = false
						end)
					end
				end)
			end

			function Section:Toggle(ToggleTitle, isToggled, callback, Extra)
				local isToggled = not isToggled
				local Extra = Extra or {}
				local Toggle = Instance.new("Frame")
				table.insert(sectionedElements, Toggle)
				local UICorner = Instance.new("UICorner")
				local Title = Instance.new("TextLabel")
				local Frame = Instance.new("ImageButton")
				local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
				local UICorner_2 = Instance.new("UICorner")
				local Overlay = Instance.new("Frame")
				local UICorner_3 = Instance.new("UICorner")

				Toggle.Name = "Toggle"
				Toggle.Parent = DropDown
				Toggle.AnchorPoint = Vector2.new(0.5, 0)
				Toggle.BackgroundColor3 = Color3.new(0.156863, 0.156863, 0.156863)
				Toggle.BorderColor3 = Color3.new(0.137255, 0.137255, 0.137255)
				Toggle.BorderSizePixel = 0
				Toggle.Position = UDim2.new(0.5, 0, 0, 0)
				--Toggle.Size = UDim2.new(0,290,0,40)
				Toggle.Size = BaseItemSize_Section

				UICorner.Parent = Toggle

				Title.Name = "Title"
				Title.Parent = Toggle
				Title.AnchorPoint = Vector2.new(0.5, .5)
				Title.BackgroundColor3 = Color3.new(1, 1, 1)
				Title.BackgroundTransparency = 1
				Title.BorderColor3 = Color3.new(0, 0, 0)
				Title.BorderSizePixel = 0
				Title.Position = UDim2.new(0.35952127, 0, 0.5, 0)
				Title.Size = UDim2.new(0.667221844, 0, 0.5, 0)
				Title.Font = Enum.Font.FredokaOne
				Title.Text = ToggleTitle or "Toggle"
				Title.TextColor3 = Color3.new(1, 1, 1)
				Title.TextScaled = true
				Title.TextSize = 14
				Title.TextWrapped = true
				Title.TextXAlignment = Enum.TextXAlignment.Left

				Frame.Parent = Toggle
				Frame.AnchorPoint = Vector2.new(1, 0.5)
				Frame.BackgroundColor3 = Color3.new(0.156863, 0.156863, 0.156863)
				Frame.BorderColor3 = Color3.new(0, 0, 0)
				Frame.BorderSizePixel = 0
				Frame.Position = UDim2.new(0.980000019, 0, 0.5, 0)
				Frame.Size = UDim2.new(0.75, 0, 0.75, 0)
				Frame.Image = ""
				Frame.ImageTransparency = 1

				local UIStroke = Instance.new("UIStroke", Frame)
				UIStroke.Color = Color3.fromRGB(50,50,50)

				UIAspectRatioConstraint.Parent = Frame

				UICorner_2.Parent = Frame

				Overlay.Name = "Overlay"
				Overlay.Parent = Toggle
				Overlay.AnchorPoint = Vector2.new(1, 0)
				Overlay.BackgroundColor3 = Color3.new(1, 1, 1)
				Overlay.BackgroundTransparency = 0.6000000238418579
				Overlay.BorderColor3 = Color3.new(0, 0, 0)
				Overlay.BorderSizePixel = 0
				Overlay.Position = UDim2.new(1, 0, 0, 0)
				Overlay.Size = UDim2.new(1, 0, 1, 0)
				Overlay.ZIndex = 0
				local Gradient = Instance.new("UIGradient")
				Gradient.Transparency = NumberSequence.new({
					NumberSequenceKeypoint.new(0,0),
					NumberSequenceKeypoint.new(1,1)
				})
				Gradient.Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0,Color3.fromRGB(0,155,255)),
					ColorSequenceKeypoint.new(1,Color3.fromRGB(40,40,40))
				})
				Gradient.Rotation = -180
				Gradient.Parent = Overlay
				UICorner_3.Parent = Overlay

				Overlay.Size = (isToggled and UDim2.new(1, 0, 1, 0)) or UDim2.new(0, 0, 1, 0)
				UIStroke.Color = (isToggled and Color3.fromRGB(0,155,255)) or Color3.fromRGB(50,50,50)

				local toggled = isToggled
				local toggleDB = false
				function Toggle()
					if not toggleDB then
						toggleDB = true

						if isToggled then
							isToggled = false
							Overlay:TweenSize(
								UDim2.new(0,0,1,0),
								Enum.EasingDirection.Out,
								Enum.EasingStyle.Sine,
								.1,
								true,
								function()
									toggleDB = false
								end
							)
							game.TweenService:Create(UIStroke, TweenInfo.new(.1), {Color=Color3.fromRGB(50,50,50)}):Play()
						else
							isToggled = true
							Overlay:TweenSize(
								UDim2.new(1,0,1,0),
								Enum.EasingDirection.Out,
								Enum.EasingStyle.Sine,
								.1,
								true,
								function()
									toggleDB = false
								end
							)
							game.TweenService:Create(UIStroke, TweenInfo.new(.1), {Color=Color3.fromRGB(0,155,255)}):Play()
						end
						callback(isToggled)
					end
				end
				Frame.MouseButton1Click:Connect(function()
					Toggle()
				end)
				Toggle()
			end

			function Section:Section(sectionTitle)
				local NestedSection = {
					title = sectionTitle,
					elements = {}
				}

				local NestedDropDown = Instance.new("Frame")
				local NestedUIListLayout = Instance.new("UIListLayout")
				local NestedDropdownMain = Instance.new("Frame")
				local NestedDropdownArrow = Instance.new("TextLabel")
				local NestedDropdownTitle = Instance.new("TextLabel")
				local NestedUICorner = Instance.new("UICorner")
				local NestedUICorner_2 = Instance.new("UICorner")

				NestedDropDown.Name = "NestedDropDown"
				NestedDropDown.Parent = DropDown
				NestedDropDown.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
				NestedDropDown.BorderColor3 = Color3.new(0, 0, 0)
				NestedDropDown.BorderSizePixel = 0
				NestedDropDown.Position = UDim2.new(0.0638888925, 0, -0.612167299, 0)
				NestedDropDown.Size = BaseSection_Size
				NestedDropDown.ClipsDescendants = true

				table.insert(dropdownFrames, NestedDropDown)

				NestedUIListLayout.Parent = NestedDropDown
				NestedUIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
				NestedUIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
				NestedUIListLayout.Padding = UDim.new(0, 5)

				NestedDropdownMain.Name = "NestedDropdownMain"
				NestedDropdownMain.Parent = NestedDropDown
				NestedDropdownMain.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
				NestedDropdownMain.BorderColor3 = Color3.new(0, 0, 0)
				NestedDropdownMain.BorderSizePixel = 0
				NestedDropdownMain.LayoutOrder = -1
				NestedDropdownMain.Position = UDim2.new(0.0352065153, 0, 0, 0)
				NestedDropdownMain.Size = UDim2.new(0, 302, 0, 40)

				NestedDropdownArrow.Name = "NestedDropdownArrow"
				NestedDropdownArrow.Parent = NestedDropdownMain
				NestedDropdownArrow.AnchorPoint = Vector2.new(0.5, 0)
				NestedDropdownArrow.BackgroundColor3 = Color3.new(1, 1, 1)
				NestedDropdownArrow.BackgroundTransparency = 1
				NestedDropdownArrow.BorderColor3 = Color3.new(0, 0, 0)
				NestedDropdownArrow.BorderSizePixel = 0
				NestedDropdownArrow.Position = UDim2.new(0.942646146, 0, 0.34018153, 0)
				NestedDropdownArrow.Size = UDim2.new(0, 10, 0, 12)
				NestedDropdownArrow.Font = Enum.Font.FredokaOne
				NestedDropdownArrow.Text = "V"
				NestedDropdownArrow.TextColor3 = Color3.new(0.784314, 0.784314, 0.784314)
				NestedDropdownArrow.TextScaled = true
				NestedDropdownArrow.TextSize = 14
				NestedDropdownArrow.TextWrapped = true
				NestedDropdownArrow.TextXAlignment = Enum.TextXAlignment.Left

				NestedDropdownTitle.Name = "NestedDropdownTitle"
				NestedDropdownTitle.Parent = NestedDropdownMain
				NestedDropdownTitle.AnchorPoint = Vector2.new(0.5, 0.5)
				NestedDropdownTitle.BackgroundColor3 = Color3.new(1, 1, 1)
				NestedDropdownTitle.BackgroundTransparency = 1
				NestedDropdownTitle.BorderColor3 = Color3.new(0, 0, 0)
				NestedDropdownTitle.BorderSizePixel = 0
				NestedDropdownTitle.Position = UDim2.new(0.403059602, 0, 0.5, 0)
				NestedDropdownTitle.Size = UDim2.new(0, 226, 0, 16)
				NestedDropdownTitle.Font = Enum.Font.FredokaOne
				NestedDropdownTitle.Text = sectionTitle or "Nested Section"
				NestedDropdownTitle.TextColor3 = Color3.new(0.784314, 0.784314, 0.784314)
				NestedDropdownTitle.TextScaled = true
				NestedDropdownTitle.TextSize = 14
				NestedDropdownTitle.TextWrapped = true
				NestedDropdownTitle.TextXAlignment = Enum.TextXAlignment.Left

				NestedUICorner.Parent = NestedDropdownMain

				NestedUICorner_2.Parent = NestedDropDown

				local Button = Instance.new("ImageButton")
				Button.Parent = NestedDropdownMain
				Button.Image = ""
				Button.ImageTransparency = 1
				Button.BackgroundTransparency = 1
				Button.Size = UDim2.new(1,0,1,0)

				local sectionIsOpen = false
				local DB = false

				local function updateParentSize()
					if sectionIsOpen then
						NestedDropDown.Size = UDim2.new(0, NestedDropDown.Size.X.Offset, 0, CalculateSize(NestedDropDown, NestedUIListLayout, Scaleable.Scale))--/Scaleable.Scale)
					else
						NestedDropDown.Size = UDim2.new(0, NestedDropDown.Size.X.Offset, 0, NestedDropdownMain.Size.Y.Offset)
					end
				end

				local function UpdateParentSize()
					DropDown:TweenSize(
						UDim2.new(0, DropDown.Size.X.Offset, 0, CalculateSize(DropDown, UIListLayout, Scaleable.Scale)),--/Scaleable.Scale),
						Enum.EasingDirection.Out,
						Enum.EasingStyle.Sine,
						.1,
						true,
						function()
							DB=false
						end
					)
				end

				Button.MouseButton1Click:Connect(function()
					if not DB then

						DB = true
						if sectionIsOpen then
							sectionIsOpen = false
							NestedDropDown:TweenSize(
								UDim2.new(0, NestedDropDown.Size.X.Offset, 0, NestedDropdownMain.Size.Y.Offset),
								Enum.EasingDirection.Out,
								Enum.EasingStyle.Sine,
								.1,
								true,
								function()
									NestedDropDown.BackgroundTransparency = 1
									UpdateParentSize()
								end
							)
							game.TweenService:Create(NestedDropdownArrow, TweenInfo.new(.1), {Rotation=0}):Play()
						else
							sectionIsOpen = true
							NestedDropDown.BackgroundTransparency = 0
							NestedDropDown:TweenSize(
								UDim2.new(0, NestedDropDown.Size.X.Offset, 0, CalculateSize(NestedDropDown, NestedUIListLayout, Scaleable.Scale)),--/Scaleable.Scale),
								Enum.EasingDirection.Out,
								Enum.EasingStyle.Sine,
								.1,
								true,
								function()
									UpdateParentSize()
								end
							)

							game.TweenService:Create(NestedDropdownArrow, TweenInfo.new(.1), {Rotation=180}):Play()
						end
					end
				end)
				
				function NestedSection:DropDown(placeholderTitle, ItemList, callback)
					local Dropdown = {
						title = placeholderTitle,
						elements = {}
					}
					local ItemList = ItemList or {}

					local NestedDropDownX = Instance.new("Frame")
					local NestedUIListLayoutX = Instance.new("UIListLayout")
					local NestedDropdownMainX = Instance.new("Frame")
					local NestedDropdownArrowX = Instance.new("TextLabel")
					local NestedDropdownTitleX = Instance.new("TextLabel")
					local NestedUICornerX = Instance.new("UICorner")
					local NestedUICorner_2X = Instance.new("UICorner")

					NestedDropDownX.Name = "DropDown"
					NestedDropDownX.Parent = NestedDropDown
					NestedDropDownX.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
					NestedDropDownX.BorderColor3 = Color3.new(0, 0, 0)
					NestedDropDownX.BorderSizePixel = 0
					NestedDropDownX.Position = UDim2.new(0.0638888925, 0, -0.612167299, 0)
					NestedDropDownX.Size = UDim2.new(0,250,0,25)
					NestedDropDownX.ClipsDescendants = true

					table.insert(dropdownFrames, NestedDropDownX)

					NestedUIListLayoutX.Parent = NestedDropDownX
					NestedUIListLayoutX.HorizontalAlignment = Enum.HorizontalAlignment.Center
					NestedUIListLayoutX.SortOrder = Enum.SortOrder.LayoutOrder
					NestedUIListLayoutX.Padding = UDim.new(0, 5)

					NestedDropdownMainX.Name = "NestedDropdownMain"
					NestedDropdownMainX.Parent = NestedDropDownX
					--NestedDropdownMain.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
					NestedDropdownMainX.BackgroundColor3 = Color3.new(0.156863, 0.156863, 0.156863)
					NestedDropdownMainX.BorderColor3 = Color3.new(0, 0, 0)
					NestedDropdownMainX.BorderSizePixel = 0
					NestedDropdownMainX.LayoutOrder = -1
					NestedDropdownMainX.Position = UDim2.new(0.0352065153, 0, 0, 0)
					NestedDropdownMainX.Size = UDim2.new(0, 250, 0, 25)

					NestedDropdownArrowX.Name = "NestedDropdownArrow"
					NestedDropdownArrowX.Parent = NestedDropdownMainX
					NestedDropdownArrowX.AnchorPoint = Vector2.new(0.5, 0)
					NestedDropdownArrowX.BackgroundColor3 = Color3.new(1, 1, 1)
					NestedDropdownArrowX.BackgroundTransparency = 1
					NestedDropdownArrowX.BorderColor3 = Color3.new(0, 0, 0)
					NestedDropdownArrowX.BorderSizePixel = 0
					NestedDropdownArrowX.Position = UDim2.new(0.942646146, 0, 0.34018153, 0)
					NestedDropdownArrowX.Size = UDim2.new(0, 10, 0, 12)
					NestedDropdownArrowX.Font = Enum.Font.FredokaOne
					NestedDropdownArrowX.Text = "V"
					NestedDropdownArrowX.TextColor3 = Color3.new(0.784314, 0.784314, 0.784314)
					NestedDropdownArrowX.TextScaled = true
					NestedDropdownArrowX.TextSize = 14
					NestedDropdownArrowX.TextWrapped = true
					NestedDropdownArrowX.TextXAlignment = Enum.TextXAlignment.Left

					NestedDropdownTitleX.Name = "NestedDropdownTitleX"
					NestedDropdownTitleX.Parent = NestedDropdownMainX
					NestedDropdownTitleX.AnchorPoint = Vector2.new(0.5, 0.5)
					NestedDropdownTitleX.BackgroundColor3 = Color3.new(1, 1, 1)
					NestedDropdownTitleX.BackgroundTransparency = 1
					NestedDropdownTitleX.BorderColor3 = Color3.new(0, 0, 0)
					NestedDropdownTitleX.BorderSizePixel = 0
					NestedDropdownTitleX.Position = UDim2.new(0.5, 0, 0.5, 0)
					NestedDropdownTitleX.Size = UDim2.new(0, 226, 0, 16)
					NestedDropdownTitleX.Font = Enum.Font.FredokaOne
					NestedDropdownTitleX.Text = placeholderTitle or "Dropdown"
					NestedDropdownTitleX.TextColor3 = Color3.new(0.784314, 0.784314, 0.784314)
					NestedDropdownTitleX.TextScaled = true
					NestedDropdownTitleX.TextSize = 14
					NestedDropdownTitleX.TextWrapped = true
					NestedDropdownTitleX.TextXAlignment = Enum.TextXAlignment.Left

					NestedUICorner.Parent = NestedDropdownMainX

					NestedUICorner_2.Parent = NestedDropDownX

					local Button = Instance.new("ImageButton")
					Button.Parent = NestedDropdownMainX
					Button.Image = ""
					Button.ImageTransparency = 1
					Button.BackgroundTransparency = 1
					Button.Size = UDim2.new(1,0,1,0)

					local dropdownIsOpen = false
					local DB = false

					local function updateParentSize()
						if dropdownIsOpen then
							NestedDropDownX.Size = UDim2.new(0, NestedDropDownX.Size.X.Offset, 0, CalculateSize(NestedDropDownX, NestedUIListLayoutX, Scaleable.Scale))--/Scaleable.Scale)
						else
							NestedDropDownX.Size = UDim2.new(0, NestedDropDownX.Size.X.Offset, 0, NestedDropdownMainX.Size.Y.Offset)
						end
					end

					local function UpdateParentSize()
						DropDown:TweenSize(
							UDim2.new(0, DropDown.Size.X.Offset, 0, CalculateSize(DropDown, UIListLayout, Scaleable.Scale)),--/Scaleable.Scale),
							Enum.EasingDirection.Out,
							Enum.EasingStyle.Sine,
							.1,
							true,
							function()
								DB=false
							end
						)
					end
					
					local function UpdateParentSizeX()
						NestedDropDown:TweenSize(
							UDim2.new(0, NestedDropDown.Size.X.Offset, 0, CalculateSize(NestedDropDown, NestedUIListLayout, Scaleable.Scale)),--/Scaleable.Scale),
							Enum.EasingDirection.Out,
							Enum.EasingStyle.Sine,
							.1,
							true,
							function()
								DB=false
								UpdateParentSize()
							end
						)
					end
					
					Button.MouseButton1Click:Connect(function()
						if not DB then

							DB = true
							if dropdownIsOpen then
								dropdownIsOpen = false
								NestedDropDownX:TweenSize(
									UDim2.new(0, NestedDropDownX.Size.X.Offset, 0, NestedDropdownMainX.Size.Y.Offset),
									Enum.EasingDirection.Out,
									Enum.EasingStyle.Sine,
									.1,
									true,
									function()
										NestedDropDownX.BackgroundTransparency = 1
										UpdateParentSizeX()
									end
								)
								game.TweenService:Create(NestedDropdownArrowX, TweenInfo.new(.1), {Rotation=0}):Play()
							else
								dropdownIsOpen = true
								NestedDropDownX.BackgroundTransparency = 0
								NestedDropDownX:TweenSize(
									UDim2.new(0, NestedDropDownX.Size.X.Offset, 0, CalculateSize(NestedDropDownX, NestedUIListLayoutX, Scaleable.Scale)),--/Scaleable.Scale),
									Enum.EasingDirection.Out,
									Enum.EasingStyle.Sine,
									.1,
									true,
									function()
										UpdateParentSizeX()
									end
								)

								game.TweenService:Create(NestedDropdownArrowX, TweenInfo.new(.1), {Rotation=180}):Play()
							end
						end
					end)

					for i,v in pairs(ItemList) do
						local ButtonText = "Select"
						local Toggle = Instance.new("Frame")
						local UICorner = Instance.new("UICorner")
						local Title = Instance.new("TextLabel")
						local Frame = Instance.new("Frame")
						local UICorner_2 = Instance.new("UICorner")
						local TextLabel = Instance.new("TextLabel")

						Toggle.Name = "Toggle"
						Toggle.Parent = NestedDropDownX
						Toggle.AnchorPoint = Vector2.new(0.5, 0)
						Toggle.BackgroundColor3 = Color3.new(0.156863, 0.156863, 0.156863)
						Toggle.BorderColor3 = Color3.new(0.137255, 0.137255, 0.137255)
						Toggle.BorderSizePixel = 0
						Toggle.Position = UDim2.new(0.5, 0, 0, 0)
						Toggle.Size = UDim2.new(0,250,0,25)

						UICorner.Parent = Toggle

						Title.Name = "Title"
						Title.Parent = Toggle
						Title.AnchorPoint = Vector2.new(0.5, 0)
						Title.BackgroundColor3 = Color3.new(1, 1, 1)
						Title.BackgroundTransparency = 1
						Title.BorderColor3 = Color3.new(0, 0, 0)
						Title.BorderSizePixel = 0
						Title.Position = UDim2.new(0.35952127, 0, 0.316090286, 0)
						Title.Size = UDim2.new(0.667221844, 0, 0.55, 0)
						Title.Font = Enum.Font.FredokaOne
						Title.Text = v
						Title.TextColor3 = Color3.new(0.686275, 0.686275, 0.686275)
						Title.TextScaled = true
						Title.TextSize = 14
						Title.TextWrapped = true
						Title.TextXAlignment = Enum.TextXAlignment.Left

						Frame.Parent = Toggle
						Frame.AnchorPoint = Vector2.new(1, 0.5)
						Frame.BackgroundColor3 = Color3.new(0.156863, 0.156863, 0.156863)
						Frame.BorderColor3 = Color3.new(0, 0, 0)
						Frame.BorderSizePixel = 0
						Frame.Position = UDim2.new(0.97999984, 0, 0.5, 0)
						Frame.Size = UDim2.new(0.271149337, 0, 0.75, 0)

						UICorner_2.Parent = Frame

						TextLabel.Parent = Frame
						TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
						TextLabel.BackgroundColor3 = Color3.new(1, 1, 1)
						TextLabel.BackgroundTransparency = 1
						TextLabel.BorderColor3 = Color3.new(0, 0, 0)
						TextLabel.BorderSizePixel = 0
						TextLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
						TextLabel.Size = UDim2.new(1, 0, 0.5, 0)
						TextLabel.Font = Enum.Font.FredokaOne
						TextLabel.Text = ButtonText
						TextLabel.TextColor3 = Color3.new(0.686275, 0.686275, 0.686275)
						TextLabel.TextSize = 14

						local UIStroke = Instance.new("UIStroke", Frame)
						UIStroke.Color = Color3.fromRGB(50,50,50)

						local TweenTime = 0.05
						local Debounce = false
						local isHovering = false

						Frame.MouseEnter:Connect(function()
							isHovering = true
							game.TweenService:Create(UIStroke, TweenInfo.new(TweenTime), {Color=Color3.fromRGB(0,155,255)}):Play()
						end)
						Frame.MouseLeave:Connect(function()
							isHovering = false
							game.TweenService:Create(UIStroke, TweenInfo.new(TweenTime), {Color=Color3.fromRGB(50,50,50)}):Play()
						end)

						Frame.InputBegan:Connect(function(Input)
							if Input.UserInputType == Enum.UserInputType.MouseButton1 and Input.UserInputState == Enum.UserInputState.Begin and (not Debounce) then		
								Debounce = true
								callback()
								game.TweenService:Create(UIStroke, TweenInfo.new(TweenTime), {Color=Color3.fromRGB(0,155,255)}):Play()
								Frame:TweenSize(
									UDim2.new(0.271149337*Mult, 0, 0.75*Mult, 0),
									Enum.EasingDirection.Out,
									Enum.EasingStyle.Sine,
									TweenTime,
									false,
									function()
										if not isHovering then
											game.TweenService:Create(UIStroke, TweenInfo.new(TweenTime), {Color=Color3.fromRGB(50,50,50)}):Play()
										end
										Frame:TweenSize(
											UDim2.new(0.271149337, 0, 0.75, 0),
											Enum.EasingDirection.Out,
											Enum.EasingStyle.Sine,
											TweenTime
										)
									end
								)
								sectionIsOpen = false
								NestedDropDownX:TweenSize(
									UDim2.new(0, NestedDropDownX.Size.X.Offset, 0, NestedDropdownMainX.Size.Y.Offset),
									Enum.EasingDirection.Out,
									Enum.EasingStyle.Sine,
									.1,
									true,
									function()
										NestedDropDownX.BackgroundTransparency = 1
										UpdateParentSizeX()
									end
								)
								NestedDropdownTitleX.Text = placeholderTitle..": "..v
								game.TweenService:Create(NestedDropdownArrowX, TweenInfo.new(.1), {Rotation=0}):Play()
								task.delay(TweenTime*2, function()
									Debounce = false
								end)
								callback(v)
							end
						end)
					end
					
					-- Unfinished Functions
					function Dropdown:GetItems()
						
					end
					
					function Dropdown:RemoveItem()
						
					end
					
					function Dropdown:UpdateItems()
						
					end
					
					function Dropdown:Toggle(isOpen)
						
					end
					--Unfinished Functions

					return Dropdown
				end

				function NestedSection:Slider(SliderTitle, MinVal, MaxVal, callback, Extra)
					local Extra = Extra or {}

					local Slider = Instance.new("Frame")
					local UICorner = Instance.new("UICorner")
					local Title = Instance.new("TextLabel")
					local Frame = Instance.new("Frame")
					local UICorner_2 = Instance.new("UICorner")
					local Frame_2 = Instance.new("Frame")
					local UICorner_3 = Instance.new("UICorner")
					local Pointer = Instance.new("Frame")
					local Arrow = Instance.new("Frame")
					local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
					local UICorner_4 = Instance.new("UICorner")
					local Main = Instance.new("Frame")
					local UICorner_5 = Instance.new("UICorner")
					local TextLabel = Instance.new("TextLabel")

					Slider.Name = "Slider"
					Slider.Parent = NestedDropDown
					Slider.AnchorPoint = Vector2.new(0.5, 0)
					Slider.BackgroundColor3 = Color3.new(0.176471, 0.176471, 0.176471)
					Slider.BorderColor3 = Color3.new(0.137255, 0.137255, 0.137255)
					Slider.BorderSizePixel = 0
					Slider.Position = UDim2.new(0.44607842, 0, 0.540000021, 0)
					Slider.Size = BaseItemSize_Nested

					UICorner.Parent = Slider

					Title.Name = "Title"
					Title.Parent = Slider
					Title.AnchorPoint = Vector2.new(0.5, 0)
					Title.BackgroundColor3 = Color3.new(1, 1, 1)
					Title.BackgroundTransparency = 1
					Title.BorderColor3 = Color3.new(0, 0, 0)
					Title.BorderSizePixel = 0
					Title.Position = UDim2.new(0.257265508, 0, 0.316090405, 0)
					Title.Size = UDim2.new(0.462710351, 0, 0.354564667, 0)
					Title.Font = Enum.Font.FredokaOne
					Title.Text = SliderTitle
					Title.TextColor3 = Color3.new(0.686275, 0.686275, 0.686275)
					Title.TextScaled = true
					Title.TextSize = 14
					Title.TextWrapped = true
					Title.TextXAlignment = Enum.TextXAlignment.Left

					Frame.Parent = Slider
					Frame.AnchorPoint = Vector2.new(1, 0.5)
					Frame.BackgroundColor3 = Color3.new(0.156863, 0.156863, 0.156863)
					Frame.BorderColor3 = Color3.new(0, 0, 0)
					Frame.BorderSizePixel = 0
					Frame.Position = UDim2.new(0.980000019, 0, 0.491577536, 0)
					--Frame.Size = UDim2.new(0.487930983, 0, 0.283155054, 0)
					Frame.Size = UDim2.new(0.487930983, 0, 0.5, 0)

					UICorner_2.Parent = Frame

					Frame_2.Parent = Frame
					Frame_2.AnchorPoint = Vector2.new(0, 0.5)
					Frame_2.BackgroundColor3 = Color3.new(0.784314, 0.784314, 0.784314)
					Frame_2.BorderColor3 = Color3.new(0, 0, 0)
					Frame_2.BorderSizePixel = 0
					Frame_2.Position = UDim2.new(0, 0, 0.5, 0)
					Frame_2.Size = UDim2.new(0, 0, 1, 0)

					UICorner_3.Parent = Frame_2

					Pointer.Name = "Pointer"
					Pointer.Parent = Frame_2
					Pointer.AnchorPoint = Vector2.new(0.5, 1)
					Pointer.BackgroundColor3 = Color3.new(1, 1, 1)
					Pointer.BackgroundTransparency = 1
					Pointer.BorderColor3 = Color3.new(0, 0, 0)
					Pointer.BorderSizePixel = 0
					Pointer.Position = UDim2.new(1.01999998, 0, -1.8524157e-05, 0)
					Pointer.Size = UDim2.new(0, 0, 0, 0)
					Pointer.Visible = false

					Arrow.Name = "Arrow"
					Arrow.Parent = Pointer
					Arrow.BackgroundColor3 = Color3.new(0.196078, 0.196078, 0.196078)
					Arrow.BorderColor3 = Color3.new(0, 0, 0)
					Arrow.BorderSizePixel = 0
					Arrow.Position = UDim2.new(0.19005616, 0, 0.523908794, 0)
					Arrow.Rotation = 45
					Arrow.Size = UDim2.new(0.44384104, 0, 0.573330164, 0)

					UIAspectRatioConstraint.Parent = Arrow

					UICorner_4.Parent = Arrow
					UICorner_4.CornerRadius = UDim.new(0, 2)

					Main.Name = "Main"
					Main.Parent = Pointer
					Main.BackgroundColor3 = Color3.new(0.196078, 0.196078, 0.196078)
					Main.BorderColor3 = Color3.new(0, 0, 0)
					Main.BorderSizePixel = 0
					Main.Position = UDim2.new(-0.100574739, 0, 0.325616956, 0)
					Main.Size = UDim2.new(1, 0, 0.621141613, 0)

					UICorner_5.Parent = Main
					UICorner_5.CornerRadius = UDim.new(0, 4)

					TextLabel.Parent = Main
					TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
					TextLabel.BackgroundColor3 = Color3.new(1, 1, 1)
					TextLabel.BackgroundTransparency = 1
					TextLabel.BorderColor3 = Color3.new(0, 0, 0)
					TextLabel.BorderSizePixel = 0
					TextLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
					TextLabel.Size = UDim2.new(0.800000012, 0, 0.900000012, 0)
					TextLabel.Font = Enum.Font.FredokaOne
					TextLabel.Text = "0/0"
					TextLabel.TextColor3 = Color3.new(1, 1, 1)
					TextLabel.TextScaled = true
					TextLabel.TextSize = 14
					TextLabel.TextWrapped = true

					local Gradient = Instance.new("UIGradient")
					Gradient.Transparency = NumberSequence.new({
						NumberSequenceKeypoint.new(0,0),
						NumberSequenceKeypoint.new(1,1)
					})
					Gradient.Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0,Color3.fromRGB(0,155,255)),
						ColorSequenceKeypoint.new(1,Color3.fromRGB(40,40,40))
					})
					Gradient.Rotation = 180
					Gradient.Parent = Frame_2

					local Mouse = game.Players.LocalPlayer:GetMouse()

					local O = 0
					local N = MinVal
					if MinVal < 1 then
						repeat task.wait()
							N = N*10
							O = O + 1
						until N >= 1
					end

					local lastInput = 0
					local Qd = false
					local function QueueClosure()
						Qd = true
						task.spawn(function()
							repeat task.wait() until (tick()-(lastInput+1))>0
							Pointer:TweenSize(
								UDim2.new(0,0,0,0),
								Enum.EasingDirection.Out,
								Enum.EasingStyle.Sine,
								0.1,
								false,function()
									Pointer.Visible = false
									Qd = false
								end
							)
						end)
					end

					local function CalculateMath()
						local Diff = Mouse.X - Frame.AbsolutePosition.X
						if Diff < 0 then Diff = 0 end
						local Math = Diff / Frame.AbsoluteSize.X
						if Math > 1 then Math = 1 end
						local Value = tonumber(string.format("%." .. (O or 0) .. "f", (MaxVal*Math)))
						Frame_2.Size = UDim2.new(
							Math,0,
							1,0
						)
						if Value < MinVal then Value = MinVal end
						TextLabel.Text = tostring(Value).."/"..tostring(MaxVal)
						callback(Value)
					end
					
					Frame.InputBegan:Connect(function(Input)
						if Input.UserInputType == Enum.UserInputType.MouseButton1 and Input.UserInputState == Enum.UserInputState.Begin then
							QueueClosure()
							isUsingSlider = true
							Pointer.Visible = true
							Pointer:TweenSize(
								UDim2.new(0, 30, 0, 20),
								Enum.EasingDirection.Out,
								Enum.EasingStyle.Sine,
								0.1,
								false
							)
							local Connection = Mouse.Move:Connect(function()
								lastInput = tick()
								CalculateMath()
							end);CalculateMath()
							
							Frame.InputEnded:Connect(function(Input)
								if Input.UserInputType == Enum.UserInputType.MouseButton1 then
									Connection:Disconnect()
									isUsingSlider = false
								end
							end)
						end
					end)



				end

				function NestedSection:BlankSpace(CustomSize)
					local size = CustomSize or 10
					local X = Instance.new("Frame", NestedDropDown)
					X.Transparency = 1
					X.Size = UDim2.new(1,0,0,size)
				end
				
				function NestedSection:Credit(Title)
					return NestedSection:Label(Title)
				end
				
				function NestedSection:Label(LabelText, Custom)
					local Custom = Custom or {}
					local Label = {}
					local AL = Enum.TextXAlignment.Left
					if Custom.Allignment then AL = Custom.Allignment end
					local LabelFrame = Instance.new("Frame")
					local UICorner = Instance.new("UICorner")
					local Title = Instance.new("TextLabel")
					local UIPadding = Instance.new("UIPadding")

					LabelFrame.Name = "LabelFrame"
					LabelFrame.Parent = NestedDropDown
					LabelFrame.AnchorPoint = Vector2.new(0.5, 0)
					LabelFrame.BackgroundColor3 = Color3.new(0.156863, 0.156863, 0.156863)
					LabelFrame.BorderColor3 = Color3.new(0.137255, 0.137255, 0.137255)
					LabelFrame.BorderSizePixel = 0
					LabelFrame.Position = UDim2.new(0.5, 0, 0.720000029, 0)
					LabelFrame.Size = BaseItemSize_Nested

					UICorner.Parent = LabelFrame
					UICorner.CornerRadius = UDim.new(0, 5)

					Title.Name = "Title"
					Title.Parent = LabelFrame
					Title.AnchorPoint = Vector2.new(0.5, 0.5)
					Title.BackgroundColor3 = Color3.new(1, 1, 1)
					Title.BackgroundTransparency = 1
					Title.BorderColor3 = Color3.new(0, 0, 0)
					Title.BorderSizePixel = 0
					Title.Position = UDim2.new(0.5, 0, 0.5, 0)
					Title.Size = UDim2.new(1, 0, 0.4500000024, 0)
					Title.Font = Enum.Font.FredokaOne
					Title.Text = LabelText
					Title.TextColor3 = Custom.Color or Color3.new(0.686275, 0.686275, 0.686275)
					Title.TextScaled = true
					Title.TextSize = 14
					Title.TextWrapped = true
					Title.TextXAlignment = AL

					UIPadding.Parent = Title
					UIPadding.PaddingLeft = UDim.new(0.0500000007, 0)
					UIPadding.PaddingRight = UDim.new(0.0500000007, 0)

					function Label:Destroy()
						LabelFrame:Destroy()
					end
					Label.Frame = LabelFrame
					return Label

				end

				function NestedSection:Input(InputTitle, callback, Extra)
					local Extra = Extra or {}
					local Input = Instance.new("Frame")
					local UICorner = Instance.new("UICorner")
					local Title = Instance.new("TextLabel")
					local Frame = Instance.new("Frame")
					local UICorner_2 = Instance.new("UICorner")
					local TextBox = Instance.new("TextBox")
					local UIPadding = Instance.new("UIPadding")

					Input.Name = "Input"
					Input.Parent = NestedDropDown
					Input.AnchorPoint = Vector2.new(0.5, 0)
					Input.BackgroundColor3 = Color3.new(0.156863, 0.156863, 0.156863)
					Input.BorderColor3 = Color3.new(0.137255, 0.137255, 0.137255)
					Input.BorderSizePixel = 0
					Input.Position = UDim2.new(0.473856211, 0, 0.560000002, 0)
					Input.Size = BaseItemSize_Nested

					UICorner.Parent = Input

					Title.Name = "Title"
					Title.Parent = Input
					Title.AnchorPoint = Vector2.new(0.5, 0)
					Title.BackgroundColor3 = Color3.new(1, 1, 1)
					Title.BackgroundTransparency = 1
					Title.BorderColor3 = Color3.new(0, 0, 0)
					Title.BorderSizePixel = 0
					Title.Position = UDim2.new(0.35952127, 0, 0.316090286, 0)
					Title.Size = UDim2.new(0.667221844, 0, 0.354564667, 0)
					Title.Font = Enum.Font.FredokaOne
					Title.Text = InputTitle
					Title.TextColor3 = Color3.new(0.686275, 0.686275, 0.686275)
					Title.TextScaled = true
					Title.TextSize = 14
					Title.TextWrapped = true
					Title.TextXAlignment = Enum.TextXAlignment.Left

					Frame.Parent = Input
					Frame.AnchorPoint = Vector2.new(1, 0.5)
					Frame.BackgroundColor3 = Color3.new(0.156863, 0.156863, 0.156863)
					Frame.BorderColor3 = Color3.new(0, 0, 0)
					Frame.BorderSizePixel = 0
					Frame.Position = UDim2.new(0.980000019, 0, 0.49782753, 0)
					Frame.Size = UDim2.new(0.208620682, 0, 0.545655072, 0)
					
					local Stroke = Instance.new("UIStroke", Frame)
					Stroke.Color = Color3.fromRGB(50,50,50)


					UICorner_2.Parent = Frame

					TextBox.Parent = Frame
					TextBox.BackgroundColor3 = Color3.new(1, 1, 1)
					TextBox.BackgroundTransparency = 1
					TextBox.BorderColor3 = Color3.new(0, 0, 0)
					TextBox.BorderSizePixel = 0
					TextBox.Size = UDim2.new(1, 0, 1, 0)
					TextBox.Font = Enum.Font.FredokaOne
					TextBox.PlaceholderText = "Placeholder"
					TextBox.Text = ""
					TextBox.TextColor3 = Color3.new(1, 1, 1)
					TextBox.TextScaled = true
					TextBox.TextSize = 14
					TextBox.TextWrapped = true

					UIPadding.Parent = TextBox
					UIPadding.PaddingBottom = UDim.new(0.200000003, 0)
					UIPadding.PaddingLeft = UDim.new(0.200000003, 0)
					UIPadding.PaddingRight = UDim.new(0.200000003, 0)
					UIPadding.PaddingTop = UDim.new(0.200000003, 0)

					TextBox.FocusLost:Connect(function()
						if TextBox.Text ~= "" or Extra.AllowEmptyInput then
							callback(TextBox.Text)
							TextBox.Text = ""
						end
					end)
				end
				
				function NestedSection:Button(ButtonTitle, callback, ButtonText)
					local ButtonText = ButtonText or "Click"
					local Toggle = Instance.new("Frame")
					local UICorner = Instance.new("UICorner")
					local Title = Instance.new("TextLabel")
					local Frame = Instance.new("Frame")
					local UICorner_2 = Instance.new("UICorner")
					local TextLabel = Instance.new("TextLabel")

					Toggle.Name = "Toggle"
					Toggle.Parent = NestedDropDown
					Toggle.AnchorPoint = Vector2.new(0.5, 0)
					Toggle.BackgroundColor3 = Color3.new(0.156863, 0.156863, 0.156863)
					Toggle.BorderColor3 = Color3.new(0.137255, 0.137255, 0.137255)
					Toggle.BorderSizePixel = 0
					Toggle.Position = UDim2.new(0.5, 0, 0, 0)
					Toggle.Size = BaseItemSize_Nested

					UICorner.Parent = Toggle

					Title.Name = "Title"
					Title.Parent = Toggle
					Title.AnchorPoint = Vector2.new(0.5, 0)
					Title.BackgroundColor3 = Color3.new(1, 1, 1)
					Title.BackgroundTransparency = 1
					Title.BorderColor3 = Color3.new(0, 0, 0)
					Title.BorderSizePixel = 0
					Title.Position = UDim2.new(0.35952127, 0, 0.316090286, 0)
					Title.Size = UDim2.new(0.667221844, 0, 0.354564667, 0)
					Title.Font = Enum.Font.FredokaOne
					Title.Text = ButtonTitle
					Title.TextColor3 = Color3.new(0.686275, 0.686275, 0.686275)
					Title.TextScaled = true
					Title.TextSize = 14
					Title.TextWrapped = true
					Title.TextXAlignment = Enum.TextXAlignment.Left

					Frame.Parent = Toggle
					Frame.AnchorPoint = Vector2.new(1, 0.5)
					Frame.BackgroundColor3 = Color3.new(0.156863, 0.156863, 0.156863)
					Frame.BorderColor3 = Color3.new(0, 0, 0)
					Frame.BorderSizePixel = 0
					Frame.Position = UDim2.new(0.97999984, 0, 0.5, 0)
					Frame.Size = UDim2.new(0.271149337, 0, 0.75, 0)

					UICorner_2.Parent = Frame

					TextLabel.Parent = Frame
					TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
					TextLabel.BackgroundColor3 = Color3.new(1, 1, 1)
					TextLabel.BackgroundTransparency = 1
					TextLabel.BorderColor3 = Color3.new(0, 0, 0)
					TextLabel.BorderSizePixel = 0
					TextLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
					TextLabel.Size = UDim2.new(1, 0, 0.5, 0)
					TextLabel.Font = Enum.Font.FredokaOne
					TextLabel.Text = ButtonText
					TextLabel.TextColor3 = Color3.new(0.686275, 0.686275, 0.686275)
					TextLabel.TextSize = 14

					local UIStroke = Instance.new("UIStroke", Frame)
					UIStroke.Color = Color3.fromRGB(50,50,50)

					local TweenTime = 0.05
					local Debounce = false
					local isHovering = false

					Frame.MouseEnter:Connect(function()
						isHovering = true
						game.TweenService:Create(UIStroke, TweenInfo.new(TweenTime), {Color=Color3.fromRGB(0,155,255)}):Play()
					end)
					Frame.MouseLeave:Connect(function()
						isHovering = false
						game.TweenService:Create(UIStroke, TweenInfo.new(TweenTime), {Color=Color3.fromRGB(50,50,50)}):Play()
					end)

					Frame.InputBegan:Connect(function(Input)
						if Input.UserInputType == Enum.UserInputType.MouseButton1 and Input.UserInputState == Enum.UserInputState.Begin and (not Debounce) then		
							Debounce = true
							callback()
							game.TweenService:Create(UIStroke, TweenInfo.new(TweenTime), {Color=Color3.fromRGB(0,155,255)}):Play()
							Frame:TweenSize(
								UDim2.new(0.271149337*Mult, 0, 0.75*Mult, 0),
								Enum.EasingDirection.Out,
								Enum.EasingStyle.Sine,
								TweenTime,
								false,
								function()
									if not isHovering then
										game.TweenService:Create(UIStroke, TweenInfo.new(TweenTime), {Color=Color3.fromRGB(50,50,50)}):Play()
									end
									Frame:TweenSize(
										UDim2.new(0.271149337, 0, 0.75, 0),
										Enum.EasingDirection.Out,
										Enum.EasingStyle.Sine,
										TweenTime
									)
								end
							)
							task.delay(TweenTime*2, function()
								Debounce = false
							end)
						end
					end)
				end

				function NestedSection:Toggle(ToggleTitle, isToggled, callback)
					callback = callback or function() end
					local isToggled = not isToggled
					local Toggle = Instance.new("Frame")
					table.insert(sectionedElements, Toggle)
					local UICorner = Instance.new("UICorner")
					local Title = Instance.new("TextLabel")
					local Frame = Instance.new("ImageButton")
					local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
					local UICorner_2 = Instance.new("UICorner")
					local Overlay = Instance.new("ImageButton")
					local UICorner_3 = Instance.new("UICorner")

					Toggle.Name = "Toggle"
					Toggle.Parent = NestedDropDown
					Toggle.AnchorPoint = Vector2.new(0.5, 0)
					Toggle.BackgroundColor3 = Color3.new(0.156863, 0.156863, 0.156863)
					Toggle.BorderColor3 = Color3.new(0, 0, 0)
					Toggle.BorderSizePixel = 0
					Toggle.Size = BaseItemSize_Nested

					UICorner.Parent = Toggle

					Title.Name = "Title"
					Title.Parent = Toggle
					Title.AnchorPoint = Vector2.new(0, 0.5)
					Title.BackgroundColor3 = Color3.new(1, 1, 1)
					Title.BackgroundTransparency = 1
					Title.BorderColor3 = Color3.new(0, 0, 0)
					Title.BorderSizePixel = 0
					--Title.Position = UDim2.new(0.0231545795, 0, 0.5, 0)
					--Title.Size = UDim2.new(0, 226, 0, 16)
					Title.Position = UDim2.new(0.05, 0, 0.5, 0)
					Title.Size = UDim2.new(0.667221844, 0, 0.5, 0)
					Title.Font = Enum.Font.FredokaOne
					Title.Text = ToggleTitle or "Toggle"
					Title.TextColor3 = Color3.new(0.784314, 0.784314, 0.784314)
					Title.TextScaled = true
					Title.TextSize = 14
					Title.TextWrapped = true
					Title.TextXAlignment = Enum.TextXAlignment.Left

					Frame.Parent = Toggle
					Frame.AnchorPoint = Vector2.new(1, 0.5)
					Frame.BackgroundColor3 = Color3.new(0.156863, 0.156863, 0.156863)
					Frame.BorderColor3 = Color3.new(0, 0, 0)
					Frame.BorderSizePixel = 0
					Frame.Position = UDim2.new(0.980000019, 0, 0.5, 0)
					Frame.Size = UDim2.new(0.75, 0, 0.75, 0)
					Frame.Image = ""
					Frame.ImageTransparency = 1

					UIAspectRatioConstraint.Parent = Frame

					UICorner_2.Parent = Frame
					UICorner_3.Parent = Overlay

					Overlay.Name = "Overlay"
					Overlay.Parent = Toggle
					Overlay.AnchorPoint = Vector2.new(1, 0)
					Overlay.BackgroundColor3 = Color3.new(1, 1, 1)
					Overlay.BackgroundTransparency = 0.6000000238418579
					Overlay.BorderColor3 = Color3.new(0, 0, 0)
					Overlay.BorderSizePixel = 0
					Overlay.Position = UDim2.new(1, 0, 0, 0)
					Overlay.Size = UDim2.new(1, 0, 1, 0)
					Overlay.ZIndex = 0
					local Gradient = Instance.new("UIGradient")
					Gradient.Transparency = NumberSequence.new({
						NumberSequenceKeypoint.new(0,0),
						NumberSequenceKeypoint.new(1,1)
					})
					Gradient.Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0,Color3.fromRGB(0,155,255)),
						ColorSequenceKeypoint.new(1,Color3.fromRGB(40,40,40))
					})
					Gradient.Rotation = -180
					Gradient.Parent = Overlay
					UICorner_3.Parent = Overlay
					local UIStroke = Instance.new("UIStroke", Frame)

					Overlay.Size = (isToggled and UDim2.new(1, 0, 1, 0)) or UDim2.new(0, 0, 1, 0)
					UIStroke.Color = (isToggled and Color3.fromRGB(0,155,255)) or Color3.fromRGB(50,50,50)

					local toggleIsOn = isToggled or false
					local DBx = false
					local function Togglex()
						if not DBx then
							DBx = true
							toggleIsOn = not toggleIsOn
							if toggleIsOn then
								Overlay:TweenSize(UDim2.new(1,0,1,0), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, .1, true, function() DBx = false; callback(toggleIsOn) end)
								game.TweenService:Create(UIStroke, TweenInfo.new(.1), {Color=Color3.fromRGB(0,155,255)}):Play()
							else
								Overlay:TweenSize(UDim2.new(0,0,1,0), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, .1, true, function() DBx = false; callback(toggleIsOn) end)
								game.TweenService:Create(UIStroke, TweenInfo.new(.1), {Color=Color3.fromRGB(50,50,50)}):Play()
							end
						end
					end
					Frame.MouseButton1Click:Connect(function()
						Togglex()
					end)
					Togglex()

					return Toggle
				end
				return NestedSection
			end

			table.insert(Tab.sections, Section)
			return Section
		end

		table.insert(Window.tabs, Tab)
		return Tab
	end
	function UILib:CreateWindow(Title, Version, HOL)
		return UILib:CreateUI()
	end
	return Window
end

return UILib