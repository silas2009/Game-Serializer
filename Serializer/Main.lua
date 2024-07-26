local hashlib = game:GetService("ReplicatedStorage"):FindFirstChild("HashLib")
if hashlib then
	hashlib = require(hashlib)
end
function getCode()
	local clock = os.clock()
	return hashlib.md5(("\224\182\158%*\224\182\158"):format(clock)),clock
end

local ts = game:GetService("TweenService")
local uis = game:GetService("UserInputService")
local rs = game:GetService("RunService")

function createButtonTemplate(IsExplorerGui)
	local a=Instance.new"TextButton"
	a.Name="Object"
	a.Size=UDim2.new(1,0,0,18)
	a.BorderColor3=Color3.fromRGB(27,42,53)
	a.BorderSizePixel=0
	a.BackgroundColor3=Color3.fromRGB(255,255,255)
	a.AutoButtonColor=false
	a.TextSize=14
	a.TextColor3=Color3.fromRGB(0,0,0)
	a.Text=""
	local b=Instance.new"UIGradient"
	b.Rotation=90
	b.Color=ColorSequence.new(Color3.fromRGB(255,255,255),Color3.fromRGB(200,200,200))
	b.Parent=a
	local c=Instance.new"ImageLabel"
	c.Name="Icon"
	c.Size=UDim2.new(0,16,0,16)
	c.BackgroundTransparency=1
	c.Position=UDim2.new(0,1,0,1)
	c.BackgroundColor3=Color3.fromRGB(255,255,255)
	c.ImageRectSize=Vector2.new(16,16)
	c.Image="rbxasset://textures/ClassImages.png"
	c.Parent=a
	local d=Instance.new"TextLabel"
	d.Name="InstanceName"
	d.Size=UDim2.new(0,0,1,0)
	d.BackgroundTransparency=1
	d.Position=UDim2.new(0,23,0,1)
	d.BackgroundColor3=Color3.fromRGB(255,255,255)
	d.TextSize=14
	d.TextColor3=Color3.fromRGB(0,0,0)
	d.Text="Name"
	d.Font=3
	d.TextXAlignment=0
	d.Parent=a
	if IsExplorerGui then
		local e=Instance.new"ImageButton"
		e.Name="Expand"
		e.Visible=false
		e.Size=UDim2.new(0,16,0,16)
		e.BackgroundTransparency=1
		e.Position=UDim2.new(0,1,0,1)
		e.BackgroundColor3=Color3.fromRGB(255,255,255)
		e.Image="rbxassetid://10639936763"
		e.Parent=a
		c.Position = UDim2.fromOffset(25,1)
		d.Position = UDim2.fromOffset(47,1)
	end

	return a
end

function makePathButton()
	local a=Instance.new"TextButton"
	a.Name="pathButton"
	a.AutomaticSize=1
	a.Size=UDim2.new(0,0,1,0)
	a.BackgroundTransparency=1
	a.BackgroundColor3=Color3.fromRGB(255,255,255)
	a.TextSize=14
	a.TextColor3=Color3.fromRGB(255,255,255)
	a.TextYAlignment=0
	a.Font=Enum.Font.SourceSans
	return a
end

function drag(gui)
	local dragging
	local dragInput
	local dragStart
	local startPos

	local lastMousePos
	local lastGoalPos

	local tweenInfo = TweenInfo.new(0.25,Enum.EasingStyle.Cubic,Enum.EasingDirection.Out,0,false,0)

	local function Update()
		if not (startPos) then return end;
		if not (dragging) and (lastGoalPos) then
			ts:Create(gui,tweenInfo,{Position = UDim2.new(startPos.X.Scale, lastGoalPos.X.Offset, startPos.Y.Scale, lastGoalPos.Y.Offset)}):Play()
			return 
		end;

		local delta = (lastMousePos - uis:GetMouseLocation())
		local xGoal = (startPos.X.Offset - delta.X);
		local yGoal = (startPos.Y.Offset - delta.Y);
		lastGoalPos = UDim2.new(startPos.X.Scale, xGoal, startPos.Y.Scale, yGoal)
		ts:Create(gui,tweenInfo,{Position = UDim2.new(startPos.X.Scale, xGoal, startPos.Y.Scale, yGoal)}):Play()
	end;

	gui.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = gui.Position
			lastMousePos = uis:GetMouseLocation()

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	gui.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	rs.RenderStepped:Connect(Update)
end

function createUI()
	local a=Instance.new"ScreenGui"
	a.ZIndexBehavior=1
	local b=Instance.new"Frame"
	b.Name="Main"
	b.AnchorPoint=Vector2.new(0.5,0.5)
	b.Size=UDim2.new(0,450,0,300)
	b.BorderColor3=Color3.fromRGB(24,24,24)
	b.Position=UDim2.new(0.5,0,0.5,0)
	b.BackgroundColor3=Color3.fromRGB(48,48,48)
	b.Parent=a
	drag(b)
	local c=Instance.new"Frame"
	c.Name="Topbar"
	c.Size=UDim2.new(1,0,0,24)
	c.BorderColor3=Color3.fromRGB(80,0,150)
	c.BackgroundColor3=Color3.fromRGB(136,0,255)
	c.Parent=b
	local d=Instance.new"TextLabel"
	d.Name="Title"
	d.Size=UDim2.new(1,0,1,0)
	d.BackgroundTransparency=1
	d.BackgroundColor3=Color3.fromRGB(255,255,255)
	d.FontSize=6
	d.TextSize=16
	d.TextColor3=Color3.fromRGB(255,255,255)
	d.Text="RetroStudio Serializer"
	d.Font=4
	d.TextXAlignment=0
	d.Parent=c
	local e=Instance.new"UIPadding"
	e.PaddingLeft=UDim.new(0,5)
	e.Parent=d
	local f=Instance.new"TextButton"
	f.Name="Exit"
	f.AnchorPoint=Vector2.new(1,0)
	f.Size=UDim2.new(0,18,0,18)
	f.BorderColor3=Color3.fromRGB(32,32,32)
	f.Position=UDim2.new(1,-3,0,3)
	f.BackgroundColor3=Color3.fromRGB(64,64,64)
	f.FontSize=4
	f.TextSize=12
	f.TextColor3=Color3.fromRGB(200,200,200)
	f.Text="X"
	f.Font=17
	f.Parent=c
	local g=Instance.new"UIGradient"
	g.Rotation=90
	g.Color=ColorSequence.new(Color3.fromRGB(255,255,255),Color3.fromRGB(200,200,200))
	g.Parent=c
	local h=Instance.new"Frame"
	h.Name="Container"
	h.Size=UDim2.new(1,0,1,-24)
	h.BorderColor3=Color3.fromRGB(27,42,53)
	h.BackgroundTransparency=1
	h.Position=UDim2.new(0,0,0,24)
	h.BackgroundColor3=Color3.fromRGB(255,255,255)
	h.Parent=b
	local i=Instance.new"Frame"
	i.Name="Contents"
	i.Size=UDim2.new(1,0,1,-46)
	i.BorderColor3=Color3.fromRGB(12,12,12)
	i.BackgroundColor3=Color3.fromRGB(24,24,24)
	i.Parent=h
	local j=Instance.new"ScrollingFrame"
	j.Size=UDim2.new(1,0,1,-20)
	j.Position=UDim2.new(0,0,0,20)
	j.BorderColor3=Color3.fromRGB(27,42,53)
	j.BackgroundTransparency=1
	j.Active=true
	j.BackgroundColor3=Color3.fromRGB(255,255,255)
	j.CanvasSize=UDim2.new(0,0,0,0)
	j.ScrollBarImageColor3=Color3.fromRGB(0,0,0)
	j.ScrollBarThickness=8
	j.Parent=i
	local k=Instance.new"UIListLayout"
	k.SortOrder=2
	k.Parent=j
	local l=Instance.new"ScrollingFrame"
	l.Name="Path"
	l.Size=UDim2.new(1,0,0,20)
	l.BorderColor3=Color3.fromRGB(24,24,24)
	l.BackgroundTransparency=1
	l.Active=true
	l.BackgroundColor3=Color3.fromRGB(48,48,48)
	l.AutomaticCanvasSize=1
	l.ScrollingDirection=1
	l.CanvasSize=UDim2.new(0,0,0,0)
	l.ScrollBarImageColor3=Color3.fromRGB(128,128,128)
	l.ScrollBarThickness=4
	l.Parent=i
	local m=Instance.new"UIListLayout"
	m.FillDirection=0
	m.SortOrder=2
	m.Parent=l
	local n=Instance.new"UIPadding"
	n.PaddingTop=UDim.new(0,8)
	n.PaddingBottom=UDim.new(0,8)
	n.PaddingLeft=UDim.new(0,8)
	n.PaddingRight=UDim.new(0,8)
	n.Parent=h
	local o=Instance.new"Frame"
	o.Name="Bottom"
	o.AnchorPoint=Vector2.new(0,1)
	o.Size=UDim2.new(1,0,0,36)
	o.BorderColor3=Color3.fromRGB(164,164,164)
	o.BackgroundTransparency=1
	o.Position=UDim2.new(0,0,1,0)
	o.BackgroundColor3=Color3.fromRGB(255,255,255)
	o.Parent=h
	local p=Instance.new"TextButton"
	p.Name="Insert"
	p.Size=UDim2.new(0.5,-5,1,0)
	p.BorderColor3=Color3.fromRGB(24,24,24)
	p.BackgroundColor3=Color3.fromRGB(48,48,48)
	p.FontSize=6
	p.TextSize=16
	p.TextColor3=Color3.fromRGB(255,255,255)
	p.Text="Insert"
	p.Font=4
	p.Parent=o
	local q=Instance.new"UIGradient"
	q.Rotation=90
	q.Color=ColorSequence.new(Color3.fromRGB(255,255,255),Color3.fromRGB(200,200,200))
	q.Parent=p
	local r=Instance.new"TextButton"
	r.Name="Serialize"
	r.AnchorPoint=Vector2.new(1,0)
	r.Size=UDim2.new(0.5,-5,1,0)
	r.BorderColor3=Color3.fromRGB(24,24,24)
	r.Position=UDim2.new(1,0,0,0)
	r.BackgroundColor3=Color3.fromRGB(48,48,48)
	r.FontSize=6
	r.TextSize=16
	r.TextColor3=Color3.fromRGB(255,255,255)
	r.Text="Serialize"
	r.Font=4
	r.Parent=o
	local s=Instance.new"UIGradient"
	s.Rotation=90
	s.Color=ColorSequence.new(Color3.fromRGB(255,255,255),Color3.fromRGB(200,200,200))
	s.Parent=r
	return a
end

local gui = createUI()
script = {Parent = gui}
gui.Parent = game:GetService("CoreGui")

local objects = script.Parent.Main.Container.Contents.ScrollingFrame
local explorerPath = script.Parent.Main.Container.Contents.Path
local colors = {
	Idle = {Text = Color3.fromRGB(255,255,255),Color = Color3.fromRGB(46,46,46)},
	Hover = {Text = Color3.fromRGB(255,255,255),Color = Color3.fromRGB(66,66,66)},
	Click = {Text = Color3.fromRGB(255,255,255),Color = Color3.fromRGB(11,90,175)}
}
local classIcons = loadstring(game:HttpGet("https://raw.githubusercontent.com/silas2009/Game-Serializer/main/Serializer/Resources/ClassIcons.lua"))()
local currentPath = game
function explorer()
	local connections = {}
	local function clearGuis(gui)
		for i,v in pairs(gui:GetChildren()) do
			if v:IsA("GuiObject") then
				v:Destroy()
			end
		end
	end
	local function getPath(obj:Instance)
		local path = {obj}
		if obj == game then return path end
		repeat obj = obj.Parent table.insert(path,obj) until obj == game
		for i = 1, math.floor(#path/2) do
			local j = #path - i + 1
			path[i], path[j] = path[j], path[i]
		end
		return path
	end
	local function update(obj)
		if obj.Parent == currentPath then
			local button = createButtonTemplate()
			button.Icon.ImageRectOffset = classIcons[obj.ClassName] or classIcons.Nil
			button.MouseButton1Down:Connect(function()
				button.BackgroundColor3 = colors.Click.Color
				button.InstanceName.TextColor3 = colors.Click.Text
			end)
			button.MouseButton1Up:Connect(function()
				button.BackgroundColor3 = colors.Idle.Color
				button.InstanceName.TextColor3 = colors.Idle.Text
				obj:GetPropertyChangedSignal("Name"):Connect(function()
					button.InstanceName.Text = obj.Name
				end)
				clearGuis(objects)
				currentPath = obj
				for i,v in pairs(currentPath:GetChildren()) do
					update(v)
				end
				updatePathGui()
			end)
			button.MouseEnter:Connect(function()
				button.BackgroundColor3 = colors.Hover.Color
				button.InstanceName.TextColor3 = colors.Hover.Text
			end)
			button.MouseLeave:Connect(function()
				button.BackgroundColor3 = colors.Idle.Color
				button.InstanceName.TextColor3 = colors.Idle.Text
			end)
			button.BackgroundColor3 = colors.Idle.Color
			button.InstanceName.TextColor3 = colors.Idle.Text
			button.InstanceName.Text = obj.Name
			button.Parent = objects
			local parentChanged
			parentChanged = obj:GetPropertyChangedSignal("Parent"):Connect(function()
				if obj.Parent ~= currentPath then
					button:Destroy()
					parentChanged:Disconnect()
				end
			end)
		end
	end
	function updatePathGui()
		clearGuis(explorerPath)
		for i,v in pairs(getPath(currentPath)) do
			local button = makePathButton()
			button.Text = v.Name
			if i ~= #getPath(currentPath) then
				button.Text = button.Text .. "."
			end
			v:GetPropertyChangedSignal("Name"):Connect(function()
				button.Text = v.Name
				if i ~= #getPath(currentPath) then
					button.Text = button.Text .. "."
				end
			end)
			button.MouseButton1Click:Connect(function()
				currentPath = v or game
				clearGuis(objects)
				for i,v in pairs(currentPath:GetChildren()) do
					update(v)
				end
				updatePathGui()
			end)
			button.Parent = explorerPath
		end
	end

	game.DescendantAdded:Connect(update)
	game.DescendantRemoving:Connect(update)

	clearGuis(objects)
	for i,v in pairs(currentPath:GetChildren()) do
		update(v)
	end
	updatePathGui()
	local mouse = game.Players.LocalPlayer:GetMouse()
	mouse.Button1Down:Connect(function()
		if mouse.Target then
			currentPath = mouse.Target
			clearGuis(objects)
			for i,v in pairs(currentPath:GetChildren()) do
				update(v)
			end
			updatePathGui()
		end
	end)
end

local listLayout = objects:FindFirstChildOfClass("UIListLayout")
listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	objects.CanvasSize = UDim2.fromOffset(0,listLayout.AbsoluteContentSize.Y)
end)

local lastSelected

uis.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.Backspace then
		--[[for _,v in pairs(objects:GetChildren()) do
			if v:IsA("GuiButton") and v.Selected then
				v:Destroy()
			end
		end--]]
	end
end)

script.Parent.Main.Topbar.Exit.MouseButton1Click:Connect(function()
	script.Parent.Main.ClipsDescendants = true
	local tween = ts:Create(script.Parent.Main,TweenInfo.new(0.5,Enum.EasingStyle.Cubic,Enum.EasingDirection.Out,0,false,0),{Size=UDim2.fromOffset(script.Parent.Main.Size.X.Offset,0)})
	tween:Play()
	tween.Completed:Connect(function(state)
		if state == Enum.PlaybackState.Completed then
			script.Parent:Destroy()
		end
	end)
end)

local filesTable = {}
function addFiles()
	for _,v in pairs(objects:GetChildren()) do
		if v:IsA("GuiObject") then
			v:Destroy()
		end
	end
	for _,v in pairs(listfiles("Serialize")) do
		local filePath = v:split("\\")
		local fileName = filePath[#filePath]
		local fileExtension = fileName:split(".")
		if fileExtension[2] == "json" or fileExtension[2] == "txt" then
			local obj = createButtonTemplate()
			table.insert(filesTable,{fileName=v,button=obj})
			obj.InstanceName.Text = fileExtension[1]
			obj.BackgroundColor3 = colors.Idle.Color
			obj.InstanceName.TextColor3 = colors.Idle.Text
			obj.MouseEnter:Connect(function()
				if not obj.Selected then
					obj.BackgroundColor3 = colors.Hover.Color
					obj.InstanceName.TextColor3 = colors.Hover.Text
				end
			end)
			obj.MouseLeave:Connect(function()
				if not obj.Selected then
					obj.BackgroundColor3 = colors.Idle.Color
					obj.InstanceName.TextColor3 = colors.Idle.Text
				end
			end)
			obj.MouseButton1Down:Connect(function()
				if not lastSelected then
					lastSelected = obj
					obj.Selected = true
				else
					if uis:IsKeyDown(Enum.KeyCode.LeftShift) then
						for i,button in pairs(objects:GetChildren()) do
							if lastSelected.AbsolutePosition.Y < obj.AbsolutePosition.Y then
								if button:IsA("GuiButton") and button.AbsolutePosition.Y >= lastSelected.AbsolutePosition.Y and button.AbsolutePosition.Y <= obj.AbsolutePosition.Y then
									button.Selected = true
								end
							elseif lastSelected.AbsolutePosition.Y > obj.AbsolutePosition.Y then
								if button:IsA("GuiButton") and button.AbsolutePosition.Y <= lastSelected.AbsolutePosition.Y and button.AbsolutePosition.Y >= obj.AbsolutePosition.Y then
									button.Selected = true
								end
							end
						end
						lastSelected = obj
					else
						lastSelected = obj
						obj.Selected = true
					end
				end
			end)
			obj:GetPropertyChangedSignal("Selected"):Connect(function()
				if obj.Selected then
					obj.BackgroundColor3 = colors.Click.Color
					obj.InstanceName.TextColor3 = colors.Click.Text
					for _,gui in pairs(objects:GetChildren()) do
						if gui:IsA("GuiButton") and gui ~= obj then
							gui.Selected = false
						end
					end
				else
					obj.BackgroundColor3 = colors.Idle.Color
					obj.InstanceName.TextColor3 = colors.Idle.Text
				end
			end)

			obj.Parent = objects
		end
	end
end

local AllowedServices = {
	"Workspace","Lighting","StarterGui","StarterPack","Teams","SoundService"
}

local DeserializeValue = loadstring(game:HttpGet("https://raw.githubusercontent.com/silas2009/Game-Serializer/main/Serializer/Values/ValueDeserializer.lua"))()
local SerializeValue = loadstring(game:HttpGet("https://raw.githubusercontent.com/silas2009/Game-Serializer/main/Serializer/Values/ValueSerializer.lua"))()
local deSerializeScript
local Explorer
if game.PlaceId == 5846387555 then
	Explorer = game:GetService("Players").LocalPlayer.PlayerGui.StudioGui.Windows.Explorer
	deSerializeScript = loadstring(game:HttpGet("https://raw.githubusercontent.com/silas2009/Game-Serializer/main/Serializer/ScriptSerializer.lua"))()
end

local SerializeInProgress = false
local serializerFunction = loadstring(game:HttpGet("https://raw.githubusercontent.com/silas2009/Game-Serializer/main/Serializer/Serializer.lua"))()
local remoteFunctions = game:GetService("ReplicatedStorage"):FindFirstChild("RemoteFunctions")
local remoteEvents = game:GetService("ReplicatedStorage"):FindFirstChild("RemoteEvents")
local CreateObject
local ChangeProperty
local InsertToolbox
if remoteFunctions then
	CreateObject = remoteFunctions:FindFirstChild("CreateObject")
	ChangeProperty = remoteEvents:FindFirstChild("ObjectPropertyChangeRequested")
	InsertToolbox = remoteFunctions:FindFirstChild("InsertContent")
end

function createObj(ClassName,Parent)
	--[[if ClassName == "Part" then
		local part = InsertToolbox:InvokeServer("Brick","Models","Building",Vector3.zero)[1]
		spawn(function() if Parent then ChangeProperty:FireServer(part,"Parent",Parent) end end)
		return part,false
	else--]]
		local v1,v2 = getCode()
		return CreateObject:InvokeServer(ClassName,Parent,v1,v2),true
	--end
end

local insertButton = gui.Main.Container.Bottom.Insert
local insertOgColor = insertButton.BackgroundColor3

function deSerialize(objsSerialized)
	if SerializeInProgress then
		return
	end
	local done = false
	SerializeInProgress = true
	local objsSerializedSize = #objsSerialized
	local times = 0

	if game:GetService("Players").LocalPlayer:FindFirstChildOfClass("PlayerGui"):FindFirstChild("StudioGui") then -- Disable Studio Gui
		game:GetService("Players").LocalPlayer:FindFirstChildOfClass("PlayerGui"):FindFirstChild("StudioGui"):Destroy()
	end

	for i,v in ipairs(objsSerialized) do
		if v.ClassName == "Script" or v.ClassName == "LocalScript" then
			local referenceModel = v.IsReferenceModel
			if referenceModel then
				objsSerialized[i].ClassName = "StringValue"
				objsSerialized[i].Name = "ReferenceModel"
				objsSerialized[i].Value = referenceModel
			end
		elseif v.ClassName == "Part" and v.Shape and v.Shape.Name == "Cylinder" and not (v.Size.Y == v.Size.X and v.Size.Z == v.Size.X) then
			v.Shape.Name = "Block"
			local cframe = DeserializeValue.CFrame(v.CFrame)
			cframe *= CFrame.Angles(0,0,math.rad(90))
			v.CFrame = SerializeValue.CFrame(cframe)
			table.insert(
				objsSerialized,
				{
					Offset = {Y = 0,Type = "Vector3",X = 0,Z = 0},
					VertexColor = {Y = 1,Type = "Vector3",X = 1,Z = 1},
					Name = "Mesh",
					ClassName = "CylinderMesh",
					Scale = {Y = 1,Type = "Vector3",X = 1,Z = 1},
					Archivable = true,
					Parent = {Type = "Instance",["Instance"]=i}
				}
			)
		end
	end
	local ExportFolder = createObj("Folder",game:GetService("SoundService"))
	ChangeProperty:FireServer(ExportFolder,"Name","Export")
	local UnparentedFolder = createObj("Folder",ExportFolder)
	ChangeProperty:FireServer(UnparentedFolder,"Name","Unparented")
	local serviceFolders = {}
	for _,v in pairs(AllowedServices) do
		local ServiceFolder = createObj("Folder",ExportFolder)
		ChangeProperty:FireServer(ServiceFolder,"Name",v)
		table.insert(serviceFolders,ServiceFolder)
	end
	repeat task.wait() until UnparentedFolder
	for i,v in ipairs(objsSerialized) do
		local obj,waiting = createObj(v.ClassName,UnparentedFolder)

		if i == objsSerializedSize then
			done = true
		end
		if obj then
			v.Serialized = true
			v.Instance = obj
		else
			v.Serialized = false
		end
		insertButton.Text = ("Building %s/%s"):format(i,objsSerializedSize)

		if waiting then
			task.wait(0.05)
		end
	end
	spawn(function()
		repeat wait() until done
		for i, v in ipairs(objsSerialized) do
			if v.Serialized then
				local realObj = v.Instance
				if realObj:IsA("BasePart") then
					ChangeProperty:FireServer(realObj,"FormFactor","Custom")
				end
				for propName, prop in pairs(v) do
					local IsTable = typeof(prop) == "table"
					local Function
					local IsInstance = false
					if IsTable then
						Function = DeserializeValue[prop.Type]
					end
					if IsTable and prop.Type == "Instance" then
						IsInstance = true
					end
					if IsInstance then
						local instance = objsSerialized[prop.Instance]
						if instance then
							ChangeProperty:FireServer(realObj,propName,instance.Instance)
						end
						if propName == "Parent" then
							if typeof(prop.Instance) == "string" then
								local ServiceFolder
								for _,serviceFolder in pairs(serviceFolders) do
									if serviceFolder.Name == prop.Instance then
										ServiceFolder = serviceFolder
									end
								end
								if ServiceFolder then
									ChangeProperty:FireServer(realObj,propName,ServiceFolder)
								end
							end
						end
					else
						if (v.ClassName == "Script" or v.ClassName == "LocalScript") then
							if propName == "VisualSource" then
								spawn(function()
									deSerializeScript.deSerializeScript(realObj,v.VisualSource)
									print("Finished " .. v.ClassName .. ": " .. v.Name)
								end)
							end
						end
						local SetProp
						if propName ~= "Instance" and propName ~= "ClassName" and propName ~= "Serialized" then
							pcall(function()
								if Function then
									SetProp = Function(prop)
								else
									SetProp = prop
								end
							end)
							if pcall(function()return realObj[propName]end) then
								if (typeof(realObj[propName]) == "string" and SetProp ~= realObj[propName]) or typeof(realObj[propName]) ~= "string" then
									ChangeProperty:FireServer(realObj,propName,SetProp)
									if typeof(realObj[propName]) == "string" then
										task.wait()
									end
								end
							end
						end
					end
				end
				task.wait()
				insertButton.Text = ("Properties %s/%s"):format(i,#objsSerialized)
			end
		end
		ChangeProperty:FireServer(ExportFolder,"Parent",workspace)
		task.wait(0.1)
		local unusedServices = {}
		for i,v in pairs(serviceFolders) do
			if #v:GetChildren() == 0 then
				table.insert(unusedServices,v)
			end
		end
		-- remoteEvents.MiscObjectInteraction:FireServer(unusedServices,"Destroy")
		if not game:GetService("Players").LocalPlayer:FindFirstChildOfClass("PlayerGui"):FindFirstChild("StudioGui") then -- Enable Studio Gui
			game:GetService("StarterGui"):WaitForChild("StudioGui"):Clone().Parent = game:GetService("Players").LocalPlayer:FindFirstChildOfClass("PlayerGui")
		end
		insertButton.Text = "Insert"
		insertButton.BackgroundColor3 = insertOgColor
		SerializeInProgress	= false
	end)
end

local insertButton = gui.Main.Container.Bottom.Insert
insertButton.MouseButton1Click:Connect(function()
	for i,v in pairs(filesTable) do
		if v.button and v.button.Parent and v.button.Selected then
			insertButton.Text = "Inserting..."
			insertButton.BackgroundColor3 = Color3.new(insertOgColor.R/2,insertOgColor.G/2,insertOgColor.B/2)
			deSerialize(game:GetService("HttpService"):JSONDecode(readfile(v.fileName)))
			return
		end
	end
end)

function notify(Text)
	local text = Drawing.new("Text")
	text.Text = Text
	text.Size = 36
	text.Position = Vector2.new(workspace.CurrentCamera.ViewportSize.X/2,0)
	text.Outline = true
	text.Center = true
	text.OutlineColor = Color3.fromRGB(0,0,0)
	text.Visible = true
	text.Color = Color3.fromRGB(255,255,255)
	spawn(function()
		wait(3)
		text:Remove()
	end)
end

local mps = game:GetService("MarketplaceService")
local serializeButton = gui.Main.Container.Bottom.Serialize
serializeButton.MouseButton1Click:Connect(function()
	if not currentPath then return end
	local filename = string.gsub(mps:GetProductInfo(game.PlaceId).Name,"%p","")
	if currentPath ~= game and currentPath.Parent ~= game then
		filename = currentPath.ClassName .. " " .. currentPath.Name
	end
	local ogColor = serializeButton.BackgroundColor3
	serializeButton.Text = "Serializing..."
	serializeButton.BackgroundColor3 = Color3.new(ogColor.R/2,ogColor.G/2,ogColor.B/2)
	local serialized = game:GetService("HttpService"):JSONEncode(serializerFunction.Serialize(currentPath))
	task.wait(0.5)
	writefile("Serialize/" .. filename .. ".json",serialized)
	task.wait()
	serializeButton.Text = "Serialize"
	serializeButton.BackgroundColor3 = ogColor
	notify("Saved as \"" .. filename .. ".json\"")
end)

if game.PlaceId == 5846387555 then
	currentPath = nil
	local ogColor = serializeButton.BackgroundColor3
	serializeButton.AutoButtonColor = false
	serializeButton.BackgroundColor3 = Color3.new(ogColor.R/2,ogColor.G/2,ogColor.B/2)
	addFiles()
else
	explorer()
end
