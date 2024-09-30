local Deserialize = {}
function Deserialize.Vector3(Value)
	return Vector3.new(Value.X or Value.x, Value.Y or Value.y, Value.Z or Value.z)
end
function Deserialize.Vector2(Value)
	return Vector2.new(Value.X or Value.x, Value.Y or Value.y)
end
function Deserialize.EnumItem(Value)
	return Enum[Value.EnumType][Value.Name]
end
function Deserialize.Color3(Value)
	return Color3.new(Value.R or Value.r, Value.G or Value.g, Value.B or Value.b)
end
function Deserialize.BrickColor(Value)
	return BrickColor.new(Value.Name)
end
function Deserialize.CFrame(Value)
	return CFrame.new(Value.X or Value.x, Value.Y or Value.y, Value.Z or Value.z, Value.R00 or Value.R0 or Value.r0, Value.R01 or Value.R1 or Value.r1, Value.R02 or Value.R2 or Value.r2, Value.R10 or Value.r10, Value.R11 or Value.r11, Value.R12 or Value.r12, Value.R20 or Value.r20, Value.R21 or Value.r21, Value.R22 or Value.r22)
end
function Deserialize.UDim2(Value)
	return UDim2.new(Value.X.Scale,Value.X.Offset,Value.Y.Scale,Value.Y.Offset)
end
function Deserialize.UDim(Value)
	return UDim.new(Value.Scale,Value.Offset)
end
function Deserialize.NumberRange(Value)
	return NumberRange.new(Value.Min,Value.Max)
end
function Deserialize.ColorSequenceKeypoint(Value)
	return ColorSequenceKeypoint.new(Value.Time, Deserialize.Color3(Value.Value))
end
function Deserialize.ColorSequence(Value)
	local keypoints = {}
	for i,v in ipairs(Value.Keypoints) do
		table.insert(keypoints,Deserialize.ColorSequenceKeypoint(v))
	end
	return ColorSequence.new(keypoints)
end
function Deserialize.NumberSequenceKeypoint(Value)
	return NumberSequenceKeypoint.new(Value.Time,Value.Value,Value.Envelope)
end
function Deserialize.NumberSequence(Value)
	local keypoints = {}
	for i,v in ipairs(Value.Keypoints) do
		table.insert(keypoints,Deserialize.NumberSequenceKeypoint(v))
	end
	return NumberSequence.new(keypoints)
end

return Deserialize
