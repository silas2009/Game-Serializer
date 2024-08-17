local module = {}

local classIcons = loadstring(game:HttpGet("https://raw.githubusercontent.com/silas2009/Game-Serializer/main/Serializer/Resources/ClassIcons.lua"))()

function module.makeInstanceButton(parent,instance)
	local a=Instance.new"Frame"
	a.Name="Instance"
	a.Size=UDim2.new(1,0,0,18)
	a.BorderColor3=Color3.fromRGB(0,0,0)
	a.BorderSizePixel=0
	a.BackgroundColor3=Color3.fromRGB(46,46,46)
	local b=Instance.new"ImageLabel"
	b.Name="IconImage"
	b.Size=UDim2.new(0,16,0,16)
	b.BorderColor3=Color3.fromRGB(0,0,0)
	b.BackgroundTransparency=1
	b.BorderSizePixel=0
	b.BackgroundColor3=Color3.fromRGB(255,255,255)
	b.ImageRectOffset=classIcons[instance.ClassName] or classIcons.Nil
	b.ImageRectSize=Vector2.new(16,16)
	b.Image="rbxasset://textures/ClassImages.PNG"
	b.Parent=a
	local c=Instance.new"UIPadding"
	c.PaddingTop=UDim.new(0,1)
	c.PaddingBottom=UDim.new(0,1)
	c.PaddingLeft=UDim.new(0,1)
	c.PaddingRight=UDim.new(0,1)
	c.Parent=a
	local d=Instance.new"TextLabel"
	d.Name="InstanceName"
	d.AnchorPoint=Vector2.new(1,0)
	d.Size=UDim2.new(1,-20,1,0)
	d.BorderColor3=Color3.fromRGB(0,0,0)
	d.BackgroundTransparency=1
	d.Position=UDim2.new(1,0,0,0)
	d.BorderSizePixel=0
	d.BackgroundColor3=Color3.fromRGB(255,255,255)
	d.TextSize=14
	d.TextColor3=Color3.fromRGB(204,204,204)
	d.Text=instance.Name
	d.Font=Enum.Font.SourceSans
	d.TextXAlignment=0
	d.Parent=a
	local e=Instance.new"TextButton"
	e.Name="Button"
	e.Size=UDim2.new(1,0,1,0)
	e.BorderColor3=Color3.fromRGB(0,0,0)
	e.BackgroundTransparency=1
	e.BorderSizePixel=0
	e.BackgroundColor3=Color3.fromRGB(255,255,255)
	e.TextSize=14
	e.TextColor3=Color3.fromRGB(0,0,0)
	e.Text=""
	e.Font=Enum.Font.SourceSans
	e.Parent=a
	a.Parent=parent
	
	return a
end

function module.makeSideButton(parent,name)
	local a=Instance.new"TextButton"
	a.Name=name
	a.AutomaticSize=Enum.AutomaticSize.Y
	a.Size=UDim2.new(1,0,0,0)
	a.BorderColor3=Color3.fromRGB(0,0,0)
	a.BorderSizePixel=0
	a.BackgroundColor3=Color3.fromRGB(66,66,66)
	a.TextStrokeTransparency=0.75
	a.TextSize=16
	a.TextColor3=Color3.fromRGB(255,255,255)
	a.Text=name
	a.TextWrapped=true
	a.Font=Enum.Font.SourceSansBold
	local b=Instance.new"UIPadding"
	b.PaddingTop=UDim.new(0,4)
	b.PaddingBottom=UDim.new(0,4)
	b.PaddingLeft=UDim.new(0,4)
	b.PaddingRight=UDim.new(0,4)
	b.Parent = a
	a.Parent=parent
	return a
end

function module.makeDetailText(parent,name,value)
	local a=Instance.new"Frame"
	a.Name="Detail"
	a.AutomaticSize=Enum.AutomaticSize.Y
	a.Size=UDim2.new(1,0,0,0)
	a.BorderColor3=Color3.fromRGB(0,0,0)
	a.BackgroundTransparency=1
	a.BorderSizePixel=0
	a.BackgroundColor3=Color3.fromRGB(255,255,255)
	local b=Instance.new"TextLabel"
	b.Name="DetailName"
	b.AutomaticSize=Enum.AutomaticSize.Y
	b.Size=UDim2.new(0.5,0,0,0)
	b.BorderColor3=Color3.fromRGB(26,26,26)
	b.BackgroundColor3=Color3.fromRGB(46,46,46)
	b.TextSize=15
	b.TextColor3=Color3.fromRGB(204,204,204)
	b.Text=name
	b.Font=Enum.Font.SourceSans
	b.TextXAlignment=0
	b.Parent=a
	local c=Instance.new"UIPadding"
	c.PaddingTop=UDim.new(0,2)
	c.PaddingBottom=UDim.new(0,2)
	c.PaddingLeft=UDim.new(0,4)
	c.Parent=b
	local d=Instance.new"TextLabel"
	d.Name=tostring(value)
	d.AutomaticSize=Enum.AutomaticSize.Y
	d.Size=UDim2.new(0.5,0,0,0)
	d.BorderColor3=Color3.fromRGB(26,26,26)
	d.Position=UDim2.new(0.5,0,0,0)
	d.BackgroundColor3=Color3.fromRGB(46,46,46)
	d.TextSize=15
	d.TextColor3=Color3.fromRGB(204,204,204)
	d.Text="Model"
	d.Font=Enum.Font.SourceSans
	d.TextXAlignment=0
	d.Parent=a
	local e=Instance.new"UIPadding"
	e.PaddingTop=UDim.new(0,2)
	e.PaddingBottom=UDim.new(0,2)
	e.PaddingLeft=UDim.new(0,4)
	e.Parent=d
	a.Parent=parent
	return a
end

function module.makeExportedInstanceButton(parent,info,filename)
	if typeof(info) == "string" then info = game:GetService("HttpService"):JSONDecode(info) end
	local a=Instance.new"Frame"
	a.Name="ExportedInstance"
	a.Size=UDim2.new(1,0,0,26)
	a.BorderColor3=Color3.fromRGB(0,0,0)
	a.BorderSizePixel=0
	a.BackgroundColor3=Color3.fromRGB(46,46,46)
	local b=Instance.new"ImageLabel"
	b.Name="IconImage"
	b.AnchorPoint=Vector2.new(0,0.5)
	b.Size=UDim2.new(0,16,0,16)
	b.BorderColor3=Color3.fromRGB(0,0,0)
	b.BackgroundTransparency=1
	b.Position=UDim2.new(0,0,0.5,0)
	b.BorderSizePixel=0
	b.BackgroundColor3=Color3.fromRGB(255,255,255)
	b.ImageRectSize=Vector2.new(16,16)
	b.Image="rbxasset://textures/ClassImages.PNG"
	b.Parent=a
	local c=Instance.new"UIPadding"
	c.PaddingTop=UDim.new(0,1)
	c.PaddingBottom=UDim.new(0,1)
	c.PaddingLeft=UDim.new(0,1)
	c.PaddingRight=UDim.new(0,1)
	c.Parent=a
	local d=Instance.new"TextLabel"
	d.Name="InstanceName"
	d.AnchorPoint=Vector2.new(1,0)
	d.Size=UDim2.new(1,-20,1,0)
	d.BorderColor3=Color3.fromRGB(0,0,0)
	d.BackgroundTransparency=1
	d.Position=UDim2.new(1,0,0,0)
	d.BorderSizePixel=0
	d.BackgroundColor3=Color3.fromRGB(255,255,255)
	d.FontSize=5
	d.TextSize=14
	d.TextColor3=Color3.fromRGB(204,204,204)
	d.Text=filename
	d.Font=Enum.Font.SourceSans
	d.TextXAlignment=0
	d.Parent=a
	local e=Instance.new"TextButton"
	e.Name="Button"
	e.Size=UDim2.new(1,-26,1,0)
	e.BorderColor3=Color3.fromRGB(0,0,0)
	e.BackgroundTransparency=1
	e.BorderSizePixel=0
	e.BackgroundColor3=Color3.fromRGB(255,255,255)
	e.FontSize=5
	e.TextSize=14
	e.TextColor3=Color3.fromRGB(0,0,0)
	e.Text=""
	e.Font=Enum.Font.SourceSans
	e.Parent=a
	local f=Instance.new"ImageButton"
	f.Name="Delete"
	f.AnchorPoint=Vector2.new(1,0)
	f.Size=UDim2.new(0,24,0,24)
	f.BorderColor3=Color3.fromRGB(0,0,0)
	f.BackgroundTransparency=1
	f.Position=UDim2.new(1,0,0,0)
	f.BorderSizePixel=0
	f.BackgroundColor3=Color3.fromRGB(255,255,255)
	f.Image="rbxassetid://18155713435"
	f.Parent=a
	a.Parent=parent

	local mainInstance
	for i,v in pairs(info) do
		if v.Parent and (v.Parent.Instance == "Workspace" or not v.Parent.Instance) then
			mainInstance = v
			break
		end
	end
	b.ImageRectOffset = mainInstance and classIcons[mainInstance.ClassName] or classIcons.Nil
	d.Text = mainInstance and mainInstance.Name or filename

	return a
end

return module
