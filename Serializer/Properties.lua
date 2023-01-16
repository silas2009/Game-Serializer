local module = {}

local BaseClasses = {
	GuiObject = {
		"Position",
		"Size",
		"Visible",
		"BackgroundColor3",
		"BackgroundTransparency",
		"BorderSizePixel",
		"Draggable",
		"Active",
		"ZIndex",
		"BorderColor3",
		"ClipsDescendants",
		"SizeConstraint"
	},
	GuiButton = {
		"AutoButtonColor",
		"Modal",
		"Selected"
	},
	JointInstance = {
		"C0",
		"C1",
		"Enabled"
	},
	BasePart = {
		"BrickColor",
		"Material",
		"Reflectance",
		"Transparency",
		"CFrame",
		"AssemblyLinearVelocity",
		"AssemblyAngularVelocity",
		"Anchored",
		"CanCollide",
		"Locked",
		"Size",
		"BackSurface",
		"BottomSurface",
		"FrontSurface",
		"LeftSurface",
		"RightSurface",
		"TopSurface"
	},
	ValueBase = {"Value"},
	["Instance"] = {"Archivable","Name","ClassName"}
}

module.Properties = {
	TextLabel = {
		"Font",
		"TextSize",
		"FontSize",
		"Text",
		"TextColor3",
		"TextScaled",
		"TextStrokeColor3",
		"TextStrokeTransparency",
		"TextTransparency",
		"TextWrapped",
		"TextXAlignment",
		"TextYAlignment"
	},
	TextButton = {
		"Font",
		"TextSize",
		"FontSize",
		"Text",
		"TextColor3",
		"TextScaled",
		"TextStrokeColor3",
		"TextStrokeTransparency",
		"TextTransparency",
		"TextWrapped",
		"TextXAlignment",
		"TextYAlignment"
	},
	TextBox = {
		"ClearTextOnFocus",
		"MultiLine",
		"Font",
		"TextSize",
		"FontSize",
		"Text",
		"TextColor3",
		"TextScaled",
		"TextStrokeColor3",
		"TextStrokeTransparency",
		"TextTransparency",
		"TextWrapped",
		"TextXAlignment",
		"TextYAlignment"
	},
	SurfaceGui = {
		"AlwaysOnTop",
		"CanvasSize",
		"Enabled",
		"Face"
	},
	ScreenGui = {
		"Enabled"
	},
	BillboardGui = {
		"AlwaysOnTop",
		"Enabled",
		"ExtentsOffset",
		"Size",
		"SizeOffset",
		"StudsOffset"
	},
	Part = {"Shape"},
	VehicleSeat = {
		"Disabled",
		"HeadsUpDisplay",
		"MaxSpeed",
		"Steer",
		"Throttle",
		"Torque",
		"TurnSpeed"
	},
	Tool = {
		"GripForward",
		"GripPos",
		"GripRight",
		"GripUp",
		"ToolTip",
		"TextureId",
		"CanBeDropped",
		"RequiresHandle",
		"Enabled"
	},
	Texture = {
		"Color3",
		"OffsetStudsU",
		"OffsetStudsV",
		"StudsPerTileU",
		"StudsPerTileV",
		"Texture",
		"Transparency",
		"Face"
	},
	Team = {
		"AutoAssignable",
		"TeamColor"
	},
	SurfaceSelection = {
		"Color3",
		"Transparency",
		"TargetSurface",
		"Visible"
	},
	SurfaceLight = {
		"Angle",
		"Brightness",
		"Color",
		"Enabled",
		"Face",
		"Range",
		"Shadows"
	},
	SpotLight = {
		"Angle",
		"Brightness",
		"Color",
		"Enabled",
		"Face",
		"Range",
		"Shadows"
	},
	SpecialMesh = {
		"MeshId",
		"MeshType",
		"Offset",
		"Scale",
		"TextureId",
		"VertexColor"
	},
	SpawnLocation = {
		"AllowTeamChangeOnTouch",
		"Neutral",
		"TeamColor",
		"Duration"
	},
	Sparkles = {
		"SparkleColor"
	},
	Sound = {
		"Looped",
		"Pitch",
		"PlaybackSpeed",
		"Playing",
		"SoundId",
		"Volume",
		"PlayOnRemove"
	},
	Smoke = {
		"Color",
		"Opacity",
		"RiseVelocity",
		"Size"
	},
	Sky = {
		"CelestialBodiesShown",
		"MoonAngularSize",
		"MoonTextureId",
		"SkyboxBk",
		"SkyboxDn",
		"SkyboxFt",
		"SkyboxLf",
		"SkyboxRt",
		"SkyboxUp",
		"StarCount",
		"SunAngularSize",
		"SunTextureId"
	},
	Skin = {"SkinColor"},
	ShirtGraphic = {
		"Color3",
		"Graphic"
	},
	Shirt = {
		"Color3",
		"ShirtTemplate"
	},
	SelectionBox = {
		"Color3",
		"LineThickness",
		"SurfaceColor3",
		"SurfaceTransparency",
		"Transparency",
		"Visible"
	},
	Seat = {"Disabled"},
	Script = {
		"Disabled",
		"Enabled"
	},
	RocketPropulsion = {
		"CartoonFactor",
		"TargetOffset",
		"TargetRadius",
		"MaxSpeed",
		"MaxThrust",
		"ThrustD",
		"ThrustP",
		"MaxTorque",
		"TurnD",
		"TurnP"
	},
	PointLight = {
		"Brightness",
		"Color",
		"Enabled",
		"Range",
		"Shadows"
	},
	Pants = {
		"Color3",
		"PantsTemplate"
	},
	Motor6D = {
		"CurrentAngle",
		"DesiredAngle",
		"MaxVelocity"
	},
	Motor = {
		"CurrentAngle",
		"DesiredAngle",
		"MaxVelocity"
	},
	Message = {"Text"},
	LocalScript = {
		"Disabled",
		"Enabled"
	},
	Humanoid = {
		"Health",
		"JumpPower",
		"MaxHealth",
		"WalkSpeed",
		"Jump",
		"PlatformStand",
		"Sit"
	},
	Hint = {"Text"},
	Hat = {
		"AttachmentForward",
		"AttachmentPos",
		"AttachmentRight",
		"AttachmentUp"
	},
	FlagStand = {"TeamColor"},
	Flag = {
		"GripForward",
		"GripPos",
		"GripRight",
		"GripUp",
		"ToolTip",
		"TeamColor",
		"TextureId",
		"CanBeDropped",
		"RequiresHandle",
		"Enabled"
	},
	Fire = {
		"Color",
		"Heat",
		"SecondaryColor",
		"Size"
	},
	Dialog = {
		"ConversationDistance",
		"GoodbyeDialog",
		"InUse",
		"InitialPrompt",
		"Purpose",
		"Tone"
	},
	DialogChoice = {
		"GoodbyeDialog",
		"ResponseDialog",
		"UserDialog"
	},
	Decal = {
		"Color3",
		"Texture",
		"Transparency",
		"Face"
	},
	CylinderMesh = {
		"Offset",
		"Scale",
		"VertexColor"
	},
	ClickDetector = {"MaxActivationDistance"},
	CharacterMesh = {
		"BaseTextureId",
		"BodyPart",
		"MeshId",
		"OverlayTextureId"
	},
	BodyVelocity = {
		"P",
		"maxForce",
		"velocity",
		"MaxForce",
		"Velocity"
	},
	BodyThrust = {
		"force",
		"location",
		"Force",
		"Location"
	},
	BodyPosition = {
		"D",
		"P",
		"maxForce",
		"position",
		"MaxForce",
		"Position"
	},
	BodyGyro = {
		"D",
		"P",
		"maxTorque",
		"MaxTorque",
		"CFrame"
	},
	BodyForce = {
		"force",
		"Force"
	},
	BodyColors = {
		"HeadColor",
		"LeftArmColor",
		"LeftLegColor",
		"RightArmColor",
		"RightLegColor",
		"TorsoColor"
	},
	BodyAngularVelocity = {
		"P",
		"angularvelocity",
		"maxTorque",
		"AngularVelocity",
		"MaxTorque"
	},
	BlockMesh = {
		"Offset",
		"Scale",
		"VertexColor"
	},
	Animation = {"AnimationId"},
	Accoutrement = {
		"AttachmentForward",
		"AttachmentPos",
		"AttachmentRight",
		"AttachmentUp"
	},
	Accessory = {
		"AttachmentPoint"
	},
	Attachment = {
		"Visible",
		"Position",
		"Orientation",
		"CFrame"
	}
}

local InstanceBaseClasses = {
	["Instance"] = {"Parent"},
	["JointInstance"] = {
		"Part0",
		"Part1"
	}
}

module.InstanceProperties = {
	SurfaceGui = {"Adornee"},
	BillboardGui = {"Adornee"},
	SurfaceSelection = {"Adornee"},
	SelectionBox = {"Adornee"},
	RocketPropulsion = {"Target"},
	ObjectValue = {"Value"},
	Model = {"PrimaryPart"},
	Humanoid = {
		"LeftLeg",
		"RightLeg",
		"WalkToPart"
	},
}

local InheritedClasses = {
	TextLabel = {"GuiObject"},
	TextButton = {"GuiObject","GuiButton"},
	TextBox = {"GuiObject"},
	ImageLabel = {"GuiObject"},
	ImageButton = {"GuiObject","GuiButton"},
	Frame = {"GuiObject"},
	Weld = {"JointInstance"},
	Part = {"BasePart"},
	Wedge = {"BasePart"},
	VehicleSeat = {"BasePart"},
	Vector3Value = {"ValueBase"},
	Truss = {"BasePart"},
	StringValue = {"ValueBase"},
	SpawnLocation = {"BasePart"},
	Seat = {"BasePart"},
	NumberValue = {"ValueBase"},
	Motor6D = {"JointInstance"},
	Motor = {"JointInstance"},
	ManualWeld = {"JointInstance"},
	IntValue = {"ValueBase"},
	CornerWedge = {"BasePart"},
	BrickColorValue = {"ValueBase"},
	BoolValue = {"ValueBase"}
}

for className,v in pairs(InheritedClasses) do
	for _,baseClass in pairs(v) do
		for _,Value in pairs(BaseClasses[baseClass]) do
			local Table = module.Properties[className]
			if not Table then
				module.Properties[className] = {}
				Table = module.Properties[className]
			end
			table.insert(Table,Value)
		end
	end
end

for className,v in pairs(InheritedClasses) do
	for _,baseClass in pairs(v) do
		InstanceBaseClass = InstanceBaseClasses[baseClass]
		if InstanceBaseClass then
			for _,Value in pairs(InstanceBaseClass) do
				local Table = module.InstanceProperties[className]
				if not Table then
					module.InstanceProperties[className] = {}
					Table = module.InstanceProperties[className]
				end
				table.insert(Table,Value)
			end
		end
	end
end

for i,v in pairs(module.InstanceProperties) do
	for _,propName in pairs(InstanceBaseClasses.Instance) do
		table.insert(v,propName)
	end
end

for i,v in pairs(module.Properties) do
	for _,propName in pairs(BaseClasses.Instance) do
		table.insert(v,propName)
	end
	local instanceProps = module.InstanceProperties[i]
	if not instanceProps then
		module.InstanceProperties[i] = {}
		for _,propName in pairs(InstanceBaseClasses.Instance) do
			table.insert(module.InstanceProperties[i],propName)
		end
	end
end

return module
