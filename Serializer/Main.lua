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
local classIcons = {
	Nil = Vector2.new(0,0),
	Part = Vector2.new(16,0),
	CornerWedgePart = Vector2.new(16,0),
	WedgePart = Vector2.new(16,0),
	TrussPart = Vector2.new(16,0),
	Model = Vector2.new(32,0),
	Status = Vector2.new(32,0),
	ValueBase = Vector2.new(64,0),
	BoolValue = Vector2.new(64,0),
	BrickColorValue = Vector2.new(64,0),
	CFrameValue = Vector2.new(64,0),
	Color3Value = Vector2.new(64,0),
	IntValue = Vector2.new(64,0),
	NumberValue = Vector2.new(64,0),
	ObjectValue = Vector2.new(64,0),
	RayValue = Vector2.new(64,0),
	StringValue = Vector2.new(64,0),
	Vector3Value = Vector2.new(64,0),
	DoubleConstrainedValue = Vector2.new(64,0),
	IntConstrainedValue = Vector2.new(64,0),
	FloorWire = Vector2.new(64,0),
	Camera = Vector2.new(80,0),
	Script = Vector2.new(96,0),
	Decal = Vector2.new(112,0),
	SpecialMesh = Vector2.new(128,0),
	BlockMesh = Vector2.new(128,0),
	CylinderMesh = Vector2.new(128,0),
	Humanoid = Vector2.new(144,0),
	Texture = Vector2.new(160,0),
	SurfaceAppearance = Vector2.new(160,0),
	Sound = Vector2.new(176,0),
	Player = Vector2.new(192,0),
	Light = Vector2.new(208,0),
	PointLight = Vector2.new(208,0),
	SurfaceLight = Vector2.new(208,0),
	SpotLight = Vector2.new(208,0),
	Lighting = Vector2.new(208,0),
	BodyGyro = Vector2.new(224,0),
	BodyPosition = Vector2.new(224,0),
	BodyVelocity = Vector2.new(224,0),
	BodyForce = Vector2.new(224,0),
	BodyThrust = Vector2.new(224,0),
	BodyAngularVelocity = Vector2.new(224,0),
	NetworkServer = Vector2.new(240,0),
	NetworkClient = Vector2.new(256,0),
	Tool = Vector2.new(272,0),
	LocalScript = Vector2.new(288,0),
	["Workspace"] = Vector2.new(304,0),
	WorldModel = Vector2.new(304,0),
	StarterPack = Vector2.new(320,0),
	StarterGear = Vector2.new(320,0),
	Backpack = Vector2.new(320,0),
	Players = Vector2.new(336,0),
	HopperBin = Vector2.new(352,0),
	Teams = Vector2.new(368,0),
	Team = Vector2.new(384,0),
	SpawnLocation = Vector2.new(400,0),
	UIAspectRatioConstraint = Vector2.new(416,0),
	UICorner = Vector2.new(416,0),
	UIGradient = Vector2.new(416,0),
	UIGridLayout = Vector2.new(416,0),
	UIListLayout = Vector2.new(416,0),
	UIPadding = Vector2.new(416,0),
	UIPageLayout = Vector2.new(416,0),
	UIScale = Vector2.new(416,0),
	UISizeConstraint = Vector2.new(416,0),
	UIStroke = Vector2.new(416,0),
	UITableLayout = Vector2.new(416,0),
	UITextSizeConstraint = Vector2.new(416,0),
	Sky = Vector2.new(448,0),
	Atmosphere = Vector2.new(448,0),
	Clouds = Vector2.new(448,0),
	Debris = Vector2.new(480,0),
	SoundService = Vector2.new(496,0),
	Accoutrement = Vector2.new(512,0),
	Accessory = Vector2.new(512,0),
	Chat = Vector2.new(528,0),
	Message = Vector2.new(528,0),
	Hint = Vector2.new(528,0),
	JointInstance = Vector2.new(544,0),
	Weld = Vector2.new(544,0),
	Snap = Vector2.new(544,0),
	Seat = Vector2.new(560,0),
	VehicleSeat = Vector2.new(560,0),
	Platform = Vector2.new(560,0),
	SkateboardPlatform = Vector2.new(560,0),
	Explosion = Vector2.new(576,0),
	ForceField = Vector2.new(592,0),
	TouchTransmitter = Vector2.new(592,0),
	Flag = Vector2.new(608,0),
	FlagStand = Vector2.new(624,0),
	ShirtGraphic = Vector2.new(640,0),
	ClickDetector = Vector2.new(656,0),
	Sparkles = Vector2.new(672,0),
	Shirt = Vector2.new(688,0),
	Pants = Vector2.new(704,0),
	Hat = Vector2.new(720,0),
	CoreGui = Vector2.new(736,0),
	StarterGui = Vector2.new(736,0),
	PlayerGui = Vector2.new(736,0),
	MarketplaceService = Vector2.new(736,0),
	PluginDebugService = Vector2.new(736,0),
	PluginGuiService = Vector2.new(736,0),
	RobloxPluginGuiService = Vector2.new(736,0),
	ScreenGui = Vector2.new(752,0),
	GuiMain = Vector2.new(752,0),
	Frame = Vector2.new(768,0),
	ScrollingFrame = Vector2.new(768,0),
	CanvasGroup = Vector2.new(768,0),
	ImageLabel = Vector2.new(784,0),
	TextLabel = Vector2.new(800,0),
	TextButton = Vector2.new(816,0),
	TextBox = Vector2.new(816,0),
	ImageButton = Vector2.new(832,0),
	GuiButton = Vector2.new(832,0),
	ViewportFrame = Vector2.new(832,0),
	Handles = Vector2.new(848,0),
	IKControl = Vector2.new(848,0),
	SelectionBox = Vector2.new(864,0),
	SelectionSphere = Vector2.new(864,0),
	SurfaceSelection = Vector2.new(880,0),
	ArcHandles = Vector2.new(896,0),
	SelectionPartLasso = Vector2.new(912,0),
	SelectionPointLasso = Vector2.new(912,0),
	Configuration = Vector2.new(928,0),
	Smoke = Vector2.new(944,0),
	CharacterMesh = Vector2.new(960,0),
	Animation = Vector2.new(960,0),
	AnimationTrack = Vector2.new(960,0),
	Animator = Vector2.new(960,0),
	Keyframe = Vector2.new(960,0),
	KeyframeMarker = Vector2.new(960,0),
	PoseBase = Vector2.new(960,0),
	NumberPose = Vector2.new(960,0),
	Pose = Vector2.new(960,0),
	Fire = Vector2.new(976,0),
	Dialog = Vector2.new(992,0),
	DialogChoice = Vector2.new(1008,0),
	BillboardGui = Vector2.new(1024,0),
	SurfaceGui = Vector2.new(1024,0),
	Terrain = Vector2.new(1040,0),
	TerrainRegion = Vector2.new(1040,0),
	BindableFunction = Vector2.new(1056,0),
	BindableEvent = Vector2.new(1072,0),
	TestService = Vector2.new(1088,0),
	ServerStorage = Vector2.new(1104,0),
	ReplicatedFirst = Vector2.new(1120,0),
	ReplicatedStorage = Vector2.new(1120,0),
	ServerScriptService = Vector2.new(1136,0),
	NegateOperation = Vector2.new(1152,0),
	MeshPart = Vector2.new(1168,0),
	UnionOperation = Vector2.new(1168,0),
	RemoteFunction = Vector2.new(1184,0),
	RemoteEvent = Vector2.new(1200,0),
	ModuleScript = Vector2.new(1216,0),
	Folder = Vector2.new(1232,0),
	PlayerScripts = Vector2.new(1248,0),
	StandalonePluginScripts = Vector2.new(1248,0),
	StarterPlayer = Vector2.new(1264,0),
	StarterCharacterScripts = Vector2.new(1264,0),
	StarterPlayerScripts = Vector2.new(1264,0),
	ParticleEmitter = Vector2.new(1280,0),
	Attachment = Vector2.new(1296,0),
	BloomEffect = Vector2.new(1328,0),
	BlurEffect = Vector2.new(1328,0),
	ColorCorrectionEffect = Vector2.new(1328,0),
	DepthOfFieldEffect = Vector2.new(1328,0),
	SunRaysEffect = Vector2.new(1328,0),
	ChorusSoundEffect = Vector2.new(1344,0),
	CompressorSoundEffect = Vector2.new(1344,0),
	ChannelSelectorSoundEffect = Vector2.new(1344,0),
	DistortionSoundEffect = Vector2.new(1344,0),
	EchoSoundEffect = Vector2.new(1344,0),
	EqualizerSoundEffect = Vector2.new(1344,0),
	FlangeSoundEffect = Vector2.new(1344,0),
	PitchShiftSoundEffect = Vector2.new(1344,0),
	ReverbSoundEffect = Vector2.new(1344,0),
	TremoloSoundEffect = Vector2.new(1344,0),
	SoundGroup = Vector2.new(1360,0),
	BallSocketConstraint = Vector2.new(1376,0),
	Plugin = Vector2.new(1376,0),
	HingeConstraint = Vector2.new(1392,0),
	SlidingBallConstraint = Vector2.new(1408,0),
	PrismaticConstraint = Vector2.new(1408,0),
	RopeConstraint = Vector2.new(1424,0),
	RodConstraint = Vector2.new(1440,0),
	SpringConstraint = Vector2.new(1456,0),
	Trail = Vector2.new(1488,0),
	WeldConstraint = Vector2.new(1504,0),
	CylindricalConstraint = Vector2.new(1520,0),
	Beam = Vector2.new(1536,0),
	AlignPosition = Vector2.new(1584,0),
	AlignOrientation = Vector2.new(1600,0),
	LineForce = Vector2.new(1616,0),
	VectorForce = Vector2.new(1632,0),
	AngularVelocity = Vector2.new(1648,0),
	HumanoidDescription = Vector2.new(1664,0),
	NoCollisionConstraint = Vector2.new(1680,0),
	Motor6D = Vector2.new(1696,0),
	LineHandleAdornment = Vector2.new(1712,0),
	ImageHandleAdornment = Vector2.new(1728,0),
	CylinderHandleAdornment = Vector2.new(1744,0),
	ConeHandleAdornment = Vector2.new(1760,0),
	BoxHandleAdornment = Vector2.new(1776,0),
	SphereHandleAdornment = Vector2.new(1792,0),
	WireframeHandleAdornment = Vector2.new(1808,0),
	Actor = Vector2.new(1808,0),
	Bone = Vector2.new(1824,0),
	VideoFrame = Vector2.new(1920,0),
	UniversalConstraint = Vector2.new(1968,0),
	ProximityPrompt = Vector2.new(1984,0),
	TorsionSpringConstraint = Vector2.new(2000,0),
	WrapLayer = Vector2.new(2016,0),
	WrapTarget = Vector2.new(2032,0),
	PathfindingModifier = Vector2.new(2048,0),
	FaceControls = Vector2.new(2064,0),
	MaterialVariant = Vector2.new(2080,0),
	MaterialService = Vector2.new(2096,0),
	LinearVelocity = Vector2.new(2112,0),
	Highlight = Vector2.new(2128,0),
	PlaneConstraint = Vector2.new(2144,0),
	Plane = Vector2.new(2144,0),
	RigidConstraint = Vector2.new(2160,0),
	VoiceChatService = Vector2.new(2176,0),
	PathfindingLink = Vector2.new(2192,0),
	TextChatCommand = Vector2.new(2208,0),
	TextSource = Vector2.new(2224,0),
	TextChannel = Vector2.new(2240,0),
	ChatWindowConfiguration = Vector2.new(2256,0),
	ChatInputBarConfiguration = Vector2.new(2272,0),
	TextChatService = Vector2.new(2288,0),
	TerrainDetail = Vector2.new(2304,0),
	AdGui = Vector2.new(2320,0),
	AdPortal = Vector2.new(2336,0)
}
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
	print(serialized)
	-- writefile("Serialize/" .. filename .. ".json",serialized)
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
