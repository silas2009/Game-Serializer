local module = {}

function addToTable(Table,AddTable)
	for i,v in pairs(AddTable) do
		table.insert(Table,v)
	end

	return Table
end

module.Properties = {
	["Instance"] = {
		"Name",
		"ClassName"
	},
	BasePart = {
		"Size",
		"CFrame",
		"BrickColor",
		"Color",
		"Material",
		"Transparency",
		"Reflectance",
		"Anchored",
		"CanCollide",
		"Locked",
		"BackSurface",
		"BottomSurface",
		"FrontSurface",
		"LeftSurface",
		"RightSurface",
		"TopSurface"
	},
	SpecialMesh = {
		"MeshId",
		"MeshType",
		"Offset",
		"Scale",
		"TextureId",
		"VertexColor"
	},
	CylinderMesh = {
		"Offset",
		"Scale",
		"VertexColor"
	},
	BlockMesh = {
		"Offset",
		"Scale",
		"VertexColor"
	},
	CharacterMesh = {
		"BaseTextureId",
		"BodyPart",
		"MeshId",
		"OverlayTextureId"
	},
	JointInstance = {
		"C0",
		"C1"
	},
	Texture = {
		"Color3",
		"OffsetStudsU",
		"OffsetStudsV",
		"StudsPerTileU",
		"StudsPerTileV",
		"Texture",
		"Transparency",
		"ZIndex",
		"Face"
	},
	Decal = {
		"Color3",
		"Texture",
		"Transparency",
		"ZIndex",
		"Face"
	},
	Shirt = {
		"Color3",
		"ShirtTemplate"
	},
	Pants = {
		"Color3",
		"PantsTemplate"
	},
	ShirtGraphic = {
		"Color3",
		"Graphic"
	},
	Fire = {
		"Color",
		"Enabled",
		"Heat",
		"SecondaryColor",
		"Size",
		"TimeScale"
	},
	Sparkles = {
		"Enabled",
		"SparkleColor",
		"TimeScale"
	},
	Smoke = {
		"Color",
		"Enabled",
		"Opacity",
		"RiseVelocity",
		"Size",
		"TimeScale"
	},
	GuiObject = {
		"Position",
		"Size",
		"Visible",
		"Rotation",
		"BackgroundColor3",
		"BackgroundTransparency",
		"AnchorPoint",
		"BorderSizePixel",
		"ZIndex",
		"BorderColor3",
		"ClipsDescendants"
	},
	Part = {"Shape"},
	SpawnLocation = {
		"Enabled",
		"Duration",
		"AllowTeamChangeOnTouch",
		"TeamColor"
	},
	VehicleSeat = {
		"Disabled",
		"HeadsUpDisplay",
		"MaxSpeed",
		"Steer",
		"SteerFloat",
		"Throttle",
		"ThrottleFloat",
		"Torque",
		"TurnSpeed"
	},
	Seat = {
		"Disabled"
	},
	WedgePart = {},
	CornerWedgePart = {},
	TrussPart = {},
	Weld = {},
	ManualWeld = {},
	Motor6D = {},
	Motor = {},
	Frame = {},
	ImageLabel = {
		"Image",
		"ImageColor3",
		"ImageRectSize",
		"ImageTransparency",
		"ScaleType"
	},
	Humanoid = {
		"DisplayDistanceType",
		"DisplayName",
		"HealthDisplayDistance",
		"HealthDisplayType",
		"NameDisplayDistance",
		"NameOcclusion",
		"RigType",
		"BreakJointsOnDeath",
		"RequiresNeck",
		"Jump",
		"PlatformStand",
		"Sit",
		"MaxHealth",
		"Health",
		"HipHeight",
		"MaxSlopeAngle",
		"WalkSpeed",
		"JumpHeight",
		"JumpPower",
		"UseJumpPower"
	},
	BoolValue = {"Value"},
	BrickColorValue = {"Value"},
	IntValue = {"Value"},
	NumberValue = {"Value"},
	StringValue = {"Value"},
	Vector3Value = {"Value"},
	Sound = {
		"PlayOnRemove",
		"SoundId",
		"Looped",
		"Pitch",
		"PlaybackSpeed",
		"Playing",
		"TimePosition",
		"Volume"
	},
	BodyColors = {
		"HeadColor",
		"LeftArmColor",
		"LeftLegColor",
		"RightArmColor",
		"RightLegColor",
		"TorsoColor"
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
	PointLight = {
		"Brightness",
		"Color",
		"Enabled",
		"Range",
		"Shadows"
	}
}

addToTable(module.Properties.Part,module.Properties.BasePart)
addToTable(module.Properties.SpawnLocation,module.Properties.BasePart)
addToTable(module.Properties.VehicleSeat,module.Properties.BasePart)
addToTable(module.Properties.Seat,module.Properties.BasePart)
addToTable(module.Properties.WedgePart,module.Properties.BasePart)
addToTable(module.Properties.CornerWedgePart,module.Properties.BasePart)
addToTable(module.Properties.TrussPart,module.Properties.BasePart)
addToTable(module.Properties.Weld,module.Properties.JointInstance)
addToTable(module.Properties.ManualWeld,module.Properties.JointInstance)
addToTable(module.Properties.Motor6D,module.Properties.JointInstance)
addToTable(module.Properties.Motor,module.Properties.JointInstance)
addToTable(module.Properties.Frame,module.Properties.GuiObject)
addToTable(module.Properties.ImageLabel,module.Properties.GuiObject)

module.InstanceProperties = {
	["Instance"] = {
		"Parent"
	},
	JointInstance = {
		"Part0",
		"Part1",
		"Enabled"
	},
	Model = {
		"PrimaryPart"
	},
	Weld = {},
	ManualWeld = {},
	Motor6D = {
		"CurrentAngle",
		"DesiredAngle",
		"MaxVelocity"
	},
	Motor = {},
	ObjectValue = {"Value"}
}
addToTable(module.InstanceProperties.Weld,module.InstanceProperties.JointInstance)
addToTable(module.InstanceProperties.ManualWeld,module.InstanceProperties.JointInstance)
addToTable(module.InstanceProperties.Motor6D,module.InstanceProperties.JointInstance)
addToTable(module.InstanceProperties.Motor,module.InstanceProperties.JointInstance)

return module
