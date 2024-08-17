function createGUI()
	local a=Instance.new"ScreenGui"
	a.Name="RetroStudioSerializer"
	a.ZIndexBehavior=1
	local b=Instance.new"Frame"
	b.Name="Main"
	b.AnchorPoint=Vector2.new(0.5,0.5)
	b.Size=UDim2.new(0,700,0,400)
	b.BorderColor3=Color3.fromRGB(0,0,0)
	b.BackgroundTransparency=0.25
	b.Position=UDim2.new(0.5,0,0.5,0)
	b.BorderSizePixel=0
	b.BackgroundColor3=Color3.fromRGB(46,46,46)
	b.Parent=a
	local c=Instance.new"Frame"
	c.Name="Explorer"
	c.Size=UDim2.new(0.75,0,1,-32)
	c.BorderColor3=Color3.fromRGB(26,26,26)
	c.BackgroundTransparency=1
	c.Position=UDim2.new(0.25,0,0,32)
	c.BackgroundColor3=Color3.fromRGB(46,46,46)
	c.Parent=b
	local d=Instance.new"UIPadding"
	d.PaddingBottom=UDim.new(0,6)
	d.PaddingLeft=UDim.new(0,6)
	d.PaddingRight=UDim.new(0,6)
	d.Parent=c
	local e=Instance.new"Frame"
	e.Name="Top"
	e.Size=UDim2.new(1,0,1,-48)
	e.BorderColor3=Color3.fromRGB(0,0,0)
	e.BackgroundTransparency=1
	e.BorderSizePixel=0
	e.BackgroundColor3=Color3.fromRGB(255,255,255)
	e.Parent=c
	local f=Instance.new"Frame"
	f.Name="Padding"
	f.Size=UDim2.new(1,0,1,0)
	f.BorderColor3=Color3.fromRGB(26,26,26)
	f.BorderSizePixel=0
	f.BackgroundColor3=Color3.fromRGB(46,46,46)
	f.Parent=e
	local g=Instance.new"UIPadding"
	g.PaddingTop=UDim.new(0,4)
	g.PaddingBottom=UDim.new(0,4)
	g.PaddingLeft=UDim.new(0,4)
	g.PaddingRight=UDim.new(0,4)
	g.Parent=f
	local h=Instance.new"UICorner"
	h.CornerRadius=UDim.new(0,4)
	h.Parent=f
	local i=Instance.new"UIStroke"
	i.ApplyStrokeMode=1
	i.Color=Color3.fromRGB(26,26,26)
	i.Parent=f
	local j=Instance.new"Frame"
	j.Name="Tabs"
	j.Size=UDim2.new(1,0,0,32)
	j.BorderColor3=Color3.fromRGB(0,0,0)
	j.BackgroundTransparency=1
	j.BorderSizePixel=0
	j.BackgroundColor3=Color3.fromRGB(255,255,255)
	j.Parent=f
	local k=Instance.new"UIPadding"
	k.PaddingTop=UDim.new(0,2)
	k.PaddingBottom=UDim.new(0,2)
	k.PaddingLeft=UDim.new(0,2)
	k.PaddingRight=UDim.new(0,2)
	k.Parent=j
	local l=Instance.new"UIListLayout"
	l.FillDirection=0
	l.SortOrder=2
	l.Parent=j
	local m=Instance.new"Frame"
	m.Name="Explorer"
	m.Size=UDim2.new(0.5,0,1,0)
	m.BorderColor3=Color3.fromRGB(0,0,0)
	m.BackgroundTransparency=1
	m.BorderSizePixel=0
	m.BackgroundColor3=Color3.fromRGB(255,255,255)
	m.Parent=j
	local n=Instance.new"TextButton"
	n.Name="Button"
	n.Size=UDim2.new(1,0,1,0)
	n.BorderColor3=Color3.fromRGB(0,0,0)
	n.BorderSizePixel=0
	n.BackgroundColor3=Color3.fromRGB(66,66,66)
	n.FontSize=5
	n.TextSize=14
	n.TextColor3=Color3.fromRGB(255,255,255)
	n.Text="Explorer"
	n.Font=3
	n.Parent=m
	local o=Instance.new"UICorner"
	o.CornerRadius=UDim.new(0,4)
	o.Parent=n
	local p=Instance.new"UIPadding"
	p.PaddingBottom=UDim.new(0,2)
	p.Parent=n
	local q=Instance.new"UIPadding"
	q.PaddingTop=UDim.new(0,2)
	q.PaddingBottom=UDim.new(0,2)
	q.PaddingLeft=UDim.new(0,2)
	q.PaddingRight=UDim.new(0,2)
	q.Parent=m
	local r=Instance.new"Frame"
	r.Name="Selected"
	r.ZIndex=2
	r.Visible=false
	r.AnchorPoint=Vector2.new(0,1)
	r.Size=UDim2.new(1,0,0,2)
	r.BorderColor3=Color3.fromRGB(0,0,0)
	r.Position=UDim2.new(0,0,1,0)
	r.BorderSizePixel=0
	r.BackgroundColor3=Color3.fromRGB(43,177,255)
	r.Parent=m
	local s=Instance.new"Frame"
	s.Name="Exports"
	s.Size=UDim2.new(0.5,0,1,0)
	s.BorderColor3=Color3.fromRGB(0,0,0)
	s.BackgroundTransparency=1
	s.BorderSizePixel=0
	s.BackgroundColor3=Color3.fromRGB(255,255,255)
	s.Parent=j
	local t=Instance.new"TextButton"
	t.Name="Button"
	t.Size=UDim2.new(1,0,1,0)
	t.BorderColor3=Color3.fromRGB(0,0,0)
	t.BorderSizePixel=0
	t.BackgroundColor3=Color3.fromRGB(66,66,66)
	t.FontSize=5
	t.TextSize=14
	t.TextColor3=Color3.fromRGB(255,255,255)
	t.Text="Exports"
	t.Font=3
	t.Parent=s
	local u=Instance.new"UICorner"
	u.CornerRadius=UDim.new(0,4)
	u.Parent=t
	local v=Instance.new"UIPadding"
	v.PaddingBottom=UDim.new(0,2)
	v.Parent=t
	local w=Instance.new"UIPadding"
	w.PaddingTop=UDim.new(0,2)
	w.PaddingBottom=UDim.new(0,2)
	w.PaddingLeft=UDim.new(0,2)
	w.PaddingRight=UDim.new(0,2)
	w.Parent=s
	local x=Instance.new"Frame"
	x.Name="Selected"
	x.ZIndex=2
	x.Visible=false
	x.AnchorPoint=Vector2.new(0,1)
	x.Size=UDim2.new(1,0,0,2)
	x.BorderColor3=Color3.fromRGB(0,0,0)
	x.Position=UDim2.new(0,0,1,0)
	x.BorderSizePixel=0
	x.BackgroundColor3=Color3.fromRGB(43,177,255)
	x.Parent=s
	local y=Instance.new"ScrollingFrame"
	y.Name="Exports"
	y.Size=UDim2.new(1,0,1,-36)
	y.BorderColor3=Color3.fromRGB(0,0,0)
	y.BackgroundTransparency=1
	y.Position=UDim2.new(0,0,0,36)
	y.Active=true
	y.BorderSizePixel=0
	y.BackgroundColor3=Color3.fromRGB(255,255,255)
	y.AutomaticCanvasSize=2
	y.CanvasSize=UDim2.new(0,0,0,0)
	y.ScrollBarImageColor3=Color3.fromRGB(0,0,0)
	y.ScrollBarThickness=8
	y.VerticalScrollBarInset=1
	y.Parent=f
	local z=Instance.new"UIListLayout"
	z.SortOrder=2
	z.Parent=y
	local A=Instance.new"ScrollingFrame"
	A.Name="Explorer"
	A.Size=UDim2.new(1,0,1,-36)
	A.BorderColor3=Color3.fromRGB(0,0,0)
	A.BackgroundTransparency=1
	A.Position=UDim2.new(0,0,0,36)
	A.Active=true
	A.BorderSizePixel=0
	A.BackgroundColor3=Color3.fromRGB(255,255,255)
	A.AutomaticCanvasSize=2
	A.CanvasSize=UDim2.new(0,0,0,0)
	A.ScrollBarImageColor3=Color3.fromRGB(0,0,0)
	A.ScrollBarThickness=8
	A.VerticalScrollBarInset=1
	A.Parent=f
	local B=Instance.new"UIListLayout"
	B.SortOrder=2
	B.Parent=A
	local C=Instance.new"Frame"
	C.Name="Bottom"
	C.AnchorPoint=Vector2.new(0,1)
	C.Size=UDim2.new(1,0,0,36)
	C.BorderColor3=Color3.fromRGB(0,0,0)
	C.BackgroundTransparency=1
	C.Position=UDim2.new(0,0,1,0)
	C.BorderSizePixel=0
	C.BackgroundColor3=Color3.fromRGB(255,255,255)
	C.Parent=c
	local D=Instance.new"Frame"
	D.Name="Padding"
	D.Size=UDim2.new(1,0,1,0)
	D.BorderColor3=Color3.fromRGB(26,26,26)
	D.BorderSizePixel=0
	D.BackgroundColor3=Color3.fromRGB(46,46,46)
	D.Parent=C
	local E=Instance.new"UIPadding"
	E.PaddingTop=UDim.new(0,4)
	E.PaddingBottom=UDim.new(0,4)
	E.PaddingLeft=UDim.new(0,4)
	E.PaddingRight=UDim.new(0,4)
	E.Parent=D
	local F=Instance.new"UICorner"
	F.CornerRadius=UDim.new(0,4)
	F.Parent=D
	local G=Instance.new"UIStroke"
	G.ApplyStrokeMode=1
	G.Color=Color3.fromRGB(26,26,26)
	G.Parent=D
	local H=Instance.new"Frame"
	H.Name="Progress"
	H.Visible=false
	H.Size=UDim2.new(1,0,1,0)
	H.BorderColor3=Color3.fromRGB(0,0,0)
	H.BorderSizePixel=0
	H.BackgroundColor3=Color3.fromRGB(26,26,26)
	H.Parent=D
	local I=Instance.new"UIPadding"
	I.PaddingTop=UDim.new(0,2)
	I.PaddingBottom=UDim.new(0,2)
	I.PaddingLeft=UDim.new(0,2)
	I.PaddingRight=UDim.new(0,2)
	I.Parent=H
	local J=Instance.new"Frame"
	J.Name="Fill"
	J.AnchorPoint=Vector2.new(0,1)
	J.Size=UDim2.new(0.5,0,1,0)
	J.BorderColor3=Color3.fromRGB(0,0,0)
	J.Position=UDim2.new(0,0,1,0)
	J.BorderSizePixel=0
	J.BackgroundColor3=Color3.fromRGB(43,177,255)
	J.Parent=H
	local K=Instance.new"TextLabel"
	K.Name="ProgressText"
	K.ZIndex=2
	K.Size=UDim2.new(1,0,1,0)
	K.BorderColor3=Color3.fromRGB(0,0,0)
	K.BackgroundTransparency=1
	K.BorderSizePixel=0
	K.BackgroundColor3=Color3.fromRGB(255,255,255)
	K.FontSize=6
	K.TextStrokeTransparency=0.75
	K.TextSize=16
	K.TextColor3=Color3.fromRGB(255,255,255)
	K.Text="500/1000 (50%)"
	K.Font=4
	K.Parent=H
	local L=Instance.new"Frame"
	L.Name="Sidebar"
	L.Size=UDim2.new(0.25,0,1,-32)
	L.BorderColor3=Color3.fromRGB(26,26,26)
	L.BackgroundTransparency=1
	L.Position=UDim2.new(0,0,0,32)
	L.BackgroundColor3=Color3.fromRGB(46,46,46)
	L.Parent=b
	local M=Instance.new"UIPadding"
	M.PaddingBottom=UDim.new(0,6)
	M.PaddingLeft=UDim.new(0,6)
	M.PaddingRight=UDim.new(0,6)
	M.Parent=L
	local N=Instance.new"Frame"
	N.Name="Padding"
	N.Size=UDim2.new(1,0,1,0)
	N.BorderColor3=Color3.fromRGB(26,26,26)
	N.BorderSizePixel=0
	N.BackgroundColor3=Color3.fromRGB(46,46,46)
	N.Parent=L
	local O=Instance.new"UIPadding"
	O.PaddingTop=UDim.new(0,4)
	O.PaddingBottom=UDim.new(0,4)
	O.PaddingLeft=UDim.new(0,4)
	O.PaddingRight=UDim.new(0,4)
	O.Parent=N
	local P=Instance.new"ScrollingFrame"
	P.Name="Options"
	P.Size=UDim2.new(1,0,1,0)
	P.BorderColor3=Color3.fromRGB(0,0,0)
	P.BackgroundTransparency=1
	P.Active=true
	P.BorderSizePixel=0
	P.BackgroundColor3=Color3.fromRGB(255,255,255)
	P.AutomaticCanvasSize=2
	P.CanvasSize=UDim2.new(0,0,0,0)
	P.ScrollBarImageColor3=Color3.fromRGB(0,0,0)
	P.ScrollBarThickness=8
	P.VerticalScrollBarInset=1
	P.Parent=N
	local Q=Instance.new"UIListLayout"
	Q.SortOrder=2
	Q.Padding=UDim.new(0,6)
	Q.Parent=P
	local R=Instance.new"UICorner"
	R.CornerRadius=UDim.new(0,4)
	R.Parent=N
	local S=Instance.new"UIStroke"
	S.ApplyStrokeMode=1
	S.Color=Color3.fromRGB(26,26,26)
	S.Parent=N
	local T=Instance.new"Frame"
	T.Name="Details"
	T.Visible=false
	T.Size=UDim2.new(1,0,1,0)
	T.BorderColor3=Color3.fromRGB(0,0,0)
	T.BackgroundTransparency=1
	T.BorderSizePixel=0
	T.BackgroundColor3=Color3.fromRGB(255,255,255)
	T.Parent=N
	local U=Instance.new"ScrollingFrame"
	U.Visible=false
	U.Size=UDim2.new(1,0,1,-32)
	U.BorderColor3=Color3.fromRGB(0,0,0)
	U.BackgroundTransparency=1
	U.Active=true
	U.BorderSizePixel=0
	U.BackgroundColor3=Color3.fromRGB(255,255,255)
	U.AutomaticCanvasSize=2
	U.CanvasSize=UDim2.new(0,0,0,0)
	U.ScrollBarImageColor3=Color3.fromRGB(0,0,0)
	U.ScrollBarThickness=8
	U.VerticalScrollBarInset=1
	U.Parent=T
	local V=Instance.new"UIListLayout"
	V.SortOrder=2
	V.Parent=U
	local W=Instance.new"UIPadding"
	W.PaddingTop=UDim.new(0,2)
	W.PaddingBottom=UDim.new(0,2)
	W.PaddingLeft=UDim.new(0,2)
	W.PaddingRight=UDim.new(0,2)
	W.Parent=U
	local X=Instance.new"Frame"
	X.Name="Bottom"
	X.AnchorPoint=Vector2.new(0,1)
	X.Size=UDim2.new(1,0,0,32)
	X.BorderColor3=Color3.fromRGB(0,0,0)
	X.BackgroundTransparency=1
	X.Position=UDim2.new(0,0,1,0)
	X.BorderSizePixel=0
	X.BackgroundColor3=Color3.fromRGB(255,255,255)
	X.Parent=T
	local Y=Instance.new"TextButton"
	Y.Name="BackButton"
	Y.Size=UDim2.new(1,0,1,0)
	Y.BorderColor3=Color3.fromRGB(0,0,0)
	Y.BorderSizePixel=0
	Y.BackgroundColor3=Color3.fromRGB(66,66,66)
	Y.FontSize=6
	Y.TextStrokeTransparency=0.75
	Y.TextSize=16
	Y.TextColor3=Color3.fromRGB(255,255,255)
	Y.Text="Done"
	Y.Font=4
	Y.Parent=X
	local Za=Instance.new"UIPadding"
	Za.PaddingTop=UDim.new(0,4)
	Za.PaddingBottom=UDim.new(0,4)
	Za.PaddingLeft=UDim.new(0,4)
	Za.PaddingRight=UDim.new(0,4)
	Za.Parent=X
	local aa=Instance.new"UIStroke"
	aa.ApplyStrokeMode=1
	aa.Color=Color3.fromRGB(26,26,26)
	aa.Parent=b
	local ba=Instance.new"Frame"
	ba.Name="Topbar"
	ba.Size=UDim2.new(1,0,0,32)
	ba.BorderColor3=Color3.fromRGB(0,0,0)
	ba.BackgroundTransparency=1
	ba.BorderSizePixel=0
	ba.BackgroundColor3=Color3.fromRGB(255,255,255)
	ba.Parent=b
	local ca=Instance.new"TextLabel"
	ca.Size=UDim2.new(1,0,1,0)
	ca.BorderColor3=Color3.fromRGB(0,0,0)
	ca.BackgroundTransparency=1
	ca.BorderSizePixel=0
	ca.BackgroundColor3=Color3.fromRGB(255,255,255)
	ca.FontSize=6
	ca.TextStrokeTransparency=0.75
	ca.TextSize=16
	ca.TextColor3=Color3.fromRGB(255,255,255)
	ca.Text="RetroStudio Serializer"
	ca.Font=4
	ca.Parent=ba
	local da=Instance.new"TextButton"
	da.Name="Exit"
	da.AnchorPoint=Vector2.new(1,0.5)
	da.Size=UDim2.new(0,24,0,24)
	da.BorderColor3=Color3.fromRGB(0,0,0)
	da.Position=UDim2.new(1,-4,0.5,0)
	da.BorderSizePixel=0
	da.BackgroundColor3=Color3.fromRGB(46,46,46)
	da.FontSize=5
	da.TextSize=14
	da.TextColor3=Color3.fromRGB(204,204,204)
	da.Text="X"
	da.Font=2
	da.Parent=ba
	local ea=Instance.new"UIStroke"
	ea.ApplyStrokeMode=1
	ea.Color=Color3.fromRGB(26,26,26)
	ea.Parent=da
	local fa=Instance.new"UICorner"
	fa.CornerRadius=UDim.new(0,4)
	fa.Parent=da
	local ga=Instance.new"LocalScript"
	ga.Parent=a
	a.Parent=game:GetService"CoreGui"
	return ga
end

script = createGUI()

local exportsPath = "RetroStudioSerializer"

if not isfile(exportsPath) then makefolder(exportsPath) end

local players = game:GetService("Players")
local rs = game:GetService("ReplicatedStorage")
local ts = game:GetService("TweenService")

local plr = players.LocalPlayer
local serializer = loadstring(game:HttpGet("https://raw.githubusercontent.com/silas2009/Game-Serializer/main/Serializer/Serializer.lua"))()

local selectedExport

local gui = script.Parent
local mainFrame = gui:WaitForChild("Main")
local sidebar = mainFrame:WaitForChild("Sidebar")
local topbar = mainFrame:WaitForChild("Topbar")
local tabsUI = mainFrame.Explorer.Top.Padding.Tabs
local explorerScrollingFrame = mainFrame.Explorer.Top.Padding.Explorer
local exportsScrollingFrame = mainFrame.Explorer.Top.Padding.Exports
local progressBar = mainFrame.Explorer.Bottom.Padding.Progress

local makeDetailText = serializer.modules.util.guis.makeDetailText
local makeSideButton = serializer.modules.util.guis.makeSideButton
local makeInstanceButton = serializer.modules.util.guis.makeInstanceButton
local makeExportedInstanceButton = serializer.modules.util.guis.makeExportedInstanceButton

local colors = {
	Explorer={
		InstanceButton={
			Idle={Background=Color3.fromRGB(46, 46, 46),Text=Color3.fromRGB(204, 204, 204)},
			Hover={Background=Color3.fromRGB(66, 66, 66),Text=Color3.fromRGB(204, 204, 204)},
			Selected={Background=Color3.fromRGB(11, 90, 175),Text=Color3.fromRGB(255,255,255)}
		}
	}
}

function explorer()
	local stop = false
	local self = {opened=game,selected=nil,history={}}
	self.history = {self.opened}
	local connections = {}
	local buttons = {}

	local function add(obj)
		local success,button = pcall(function()
			local button = makeInstanceButton(explorerScrollingFrame,obj)
			return button
		end)
		if success then
			table.insert(buttons,button)
			table.insert(connections,obj:GetPropertyChangedSignal("Parent"):Connect(function()
				if table.find(buttons,button) then
					table.remove(buttons,table.find(buttons,button))
				end
				button:Destroy()
			end))
			table.insert(connections,obj:GetPropertyChangedSignal("Name"):Connect(function()
				button.InstanceName.Text=obj.Name
			end))
			table.insert(connections,button.Button.MouseButton1Down:Connect(function()
				if self.selected == obj then
					self:open(obj,true)
				else
					self.selected = obj
					for _,b in pairs(buttons) do
						pcall(function()
							local color = colors.Explorer.InstanceButton.Idle
							b.BackgroundColor3 = color.Background
							b.InstanceName.TextColor3 = color.Text
						end)
					end
					local color = colors.Explorer.InstanceButton.Selected
					button.BackgroundColor3 = color.Background
					button.InstanceName.TextColor3 = color.Text
				end
			end))
			table.insert(connections,button.Button.MouseEnter:Connect(function()
				if self.selected ~= obj then
					local color = colors.Explorer.InstanceButton.Hover
					button.BackgroundColor3 = color.Background
					button.InstanceName.TextColor3 = color.Text
				end
			end))
			table.insert(connections,button.Button.MouseLeave:Connect(function()
				if self.selected ~= obj then
					local color = colors.Explorer.InstanceButton.Idle
					button.BackgroundColor3 = color.Background
					button.InstanceName.TextColor3 = color.Text
				end
			end))
		end
	end

	local function update()
		for _,connection in pairs(connections) do
			connection:Disconnect()
		end
		if stop then return end
		for i,v in pairs(explorerScrollingFrame:GetChildren()) do
			if v:IsA("GuiObject") then
				v:Destroy()
			end
		end
		for _,v in pairs(self.opened:GetChildren()) do
			add(v)
		end
		table.insert(connections,self.opened.ChildAdded:Connect(add))
	end

	function self:open(instance,log)
		if log then table.insert(self.history,self.opened) end
		self.opened = instance
		update()
	end

	function self:back()
		local amount = #self.history
		if amount > 1 then
			self:open(self.history[amount])
			table.remove(self.history,amount)
		end
	end

	function self:stop()
		stop = true
		for i,v in pairs(explorerScrollingFrame:GetChildren()) do
			if v:IsA("GuiObject") then
				v:Destroy()
			end
		end
		update()
	end

	update()

	return self
end

local isStudio = game.PlaceId == 5846387555
local currentCategory = isStudio and "Explorer" or "Exports"
local currentExplorer = currentCategory == "Explorer" and explorer()
local serializing = false
local sideButtons = {
	Back = {
		func = function()
			if currentExplorer then currentExplorer:back() end
		end,
		category = {"Explorer"},
		order = {Explorer=1}
	},
	Export = {
		func = function()
			local serialized = serializer.Serialize(currentExplorer.selected,true)
			writefile(exportsPath .. "/" .. ("%s %s.json"):format(currentExplorer.selected.ClassName,currentExplorer.selected.Name),serialized)
			loadExportsList()
		end,
		category = {"Explorer"},
		order = {Explorer=2}
	},
	Import = {
		func = function()
			if serializing or not selectedExport then return end
			serializing = true
			local progressBar = mainFrame.Explorer.Bottom.Padding:WaitForChild("Progress")
			serializer.Deserialize(readfile(selectedExport),function(progress,amount,currentState)
				progressBar.Visible = true
				progressBar.Fill.BackgroundColor3 = Color3.fromHSV((progress/amount)/3,1,1)
				progressBar.Fill.Size = UDim2.fromScale(progress/amount,1)
				progressBar.ProgressText.Text = currentState .. "...\n" .. math.round((progress/amount)*100) .. "%/100%"
			end)
			serializing = false
			progressBar.Visible = false
		end,
		category = {"Exports"},
		order = {Exports=1}
	},
	Details = {
		func = function()
			sidebar.Padding.Details.Visible = true
			sidebar.Padding.Options.Visible = false
		end,
		category = {"Explorer","Exports"},
		order = {Explorer=3,Exports=2}
	}
}

function reloadSideButtons()
	for i,v in pairs(sidebar.Padding.Options:GetChildren()) do
		if v:IsA("GuiObject") then
			v:Destroy()
		end
	end
	for i,v in pairs(sideButtons) do
		if table.find(v.category,currentCategory) then
			local button = makeSideButton(sidebar.Padding.Options,i)
			button.LayoutOrder = v.order[currentCategory]
			button.MouseButton1Click:Connect(function()
				v.func()
			end)
		end
	end
end

reloadSideButtons()

sidebar.Padding.Details.Bottom.BackButton.MouseButton1Click:Connect(function()
	sidebar.Padding.Details.Visible = false
	sidebar.Padding.Options.Visible = true
end)

function selectTab(tabName)
	if tabName == "Exports" then
		exportsScrollingFrame.Visible = true
		explorerScrollingFrame.Visible = false
	elseif tabName == "Explorer" then
		explorerScrollingFrame.Visible = true
		exportsScrollingFrame.Visible = false
	end
	if currentExplorer and tabName ~= "Explorer" then currentExplorer:stop() currentExplorer = nil end
	for i,v in pairs(tabsUI:GetChildren()) do
		if v:FindFirstChild("Selected") then
			v.Selected.Visible = false
		end
	end
	tabsUI[tabName].Selected.Visible = true
	currentCategory = tabName
	reloadSideButtons()
end

function loadExportsList()
	for _,v in pairs(exportsScrollingFrame:GetChildren()) do
		if v:IsA("GuiObject") then
			v:Destroy()
		end
	end
	for _,v in pairs(listfiles(exportsPath)) do
		local filePath = v:split("/")
		local fileName = filePath[#filePath]
		local fileExtension = fileName:split(".")
		if fileExtension[2] == "json" or fileExtension[2] == "txt" then
			local button = makeExportedInstanceButton(exportsScrollingFrame,readfile(v),fileExtension[1])
			button.Delete.MouseButton1Click:Connect(function()
				delfile(v)
				loadExportsList()
			end)
			button.Button.MouseButton1Down:Connect(function()
				selectedExport = v
				for _,b in pairs(exportsScrollingFrame:GetChildren()) do
					if b:IsA("GuiObject") and b:FindFirstChild("InstanceName") then
						pcall(function()
							local color = colors.Explorer.InstanceButton.Idle
							b.BackgroundColor3 = color.Background
							b.InstanceName.TextColor3 = color.Text
						end)
					end
				end
				local color = colors.Explorer.InstanceButton.Selected
				button.BackgroundColor3 = color.Background
				button.InstanceName.TextColor3 = color.Text
			end)
			button.Button.MouseEnter:Connect(function()
				if selectedExport ~= v then
					local color = colors.Explorer.InstanceButton.Hover
					button.BackgroundColor3 = color.Background
					button.InstanceName.TextColor3 = color.Text
				end
			end)
			button.Button.MouseLeave:Connect(function()
				if selectedExport ~= v then
					local color = colors.Explorer.InstanceButton.Idle
					button.BackgroundColor3 = color.Background
					button.InstanceName.TextColor3 = color.Text
				end
			end)
		end
	end
end

loadExportsList()

tabsUI.Explorer.Button.MouseButton1Click:Connect(function()
	local lastCategory = currentCategory
	selectTab("Explorer")
	if lastCategory ~= "Explorer" then
		currentExplorer = explorer()
	end
end)
tabsUI.Exports.Button.MouseButton1Click:Connect(function()
	selectTab("Exports")
end)
topbar.Exit.MouseButton1Click:Connect(function()
	gui:Destroy()
	if currentExplorer then
		currentExplorer:stop()
	end
end)
selectTab(currentCategory)
