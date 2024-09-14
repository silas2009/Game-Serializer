local Serialize = {}
function Serialize.Vector3(Value)
	return {Type = "Vector3",X = Value.X, Y = Value.Y, Z = Value.Z}
end
function Serialize.Vector2(Value)
	return {Type = "Vector2",X = Value.X, Y = Value.Y}
end
function Serialize.EnumItem(Value)
	return {Type = "EnumItem",Name=Value.Name,EnumType=tostring(Value.EnumType)}
end
function Serialize.Color3(Value)
	return {Type = "Color3",R = Value.R, G = Value.G, B = Value.B}
end
function Serialize.BrickColor(Value)
	return {Type = "BrickColor",Name = Value.Name}
end
function Serialize.CFrame(Value)
	local x, y, z, r0, r1, r2, r10, r11, r12, r20, r21, r22 = Value:components()
	return {Type = "CFrame",X=x,Y=y,Z=z,R0=r0,R1=r1,R2=r2,R10=r10,R11=r11,R12=r12,R20=r20,R21=r21,R22=r22}
end
function Serialize.UDim2(Value)
	return {
		Type = "UDim2",
		X = {
			Offset = Value.X.Offset,
			Scale = Value.X.Scale
		},
		Y = {
			Offset = Value.Y.Offset,
			Scale = Value.Y.Scale
		}
	}
end
function Serialize.UDim(Value)
	return {
		Type = "UDim",
		Offset = Value.Offset,
		Scale = Value.Scale
	}
end
function Serialize.NumberRange(Value)
	return {
		Type = "NumberRange",
		Min = Value.Min,
		Max = Value.Max
	}
end
function Serialize.ColorSequenceKeypoint(Value)
	return {
		Type = "ColorSequenceKeypoint",
		Value = Serialize.Color3(Value.Value),
		Time = Value.Time
	}
end
function Serialize.ColorSequence(Value)
	local Keypoints = {}
	for _,Keypoint in ipairs(Value.Keypoints) do
		table.insert(Keypoints,Serialize.ColorSequenceKeypoint(Keypoint))
	end
	return {
		Type = "ColorSequence",
		Keypoints = Keypoints
	}
end
function Serialize.NumberSequenceKeypoint(Value)
	return {
		Type = "NumberSequenceKeypoint",
		Value = Value.Value,
		Time = Value.Time,
		Envelope = Value.Envelope
	}
end
function Serialize.NumberSequence(Value)
	local Keypoints = {}
	for _,Keypoint in ipairs(Value.Keypoints) do
		table.insert(Keypoints,Serialize.NumberSequenceKeypoint(Keypoint))
	end
	return {
		Type = "NumberSequence",
		Keypoints = Keypoints
	}
end

return Serialize
