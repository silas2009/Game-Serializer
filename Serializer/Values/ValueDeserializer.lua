local Deserialize = {}
function Deserialize.Vector3(Value)
	return Vector3.new(Value.X, Value.Y, Value.Z)
end
function Deserialize.Vector2(Value)
	return Vector2.new(Value.X, Value.Y)
end
function Deserialize.EnumItem(Value)
	return Enum[Value.EnumType][Value.Name]
end
function Deserialize.Color3(Value)
	return Color3.new(Value.R, Value.G, Value.B)
end
function Deserialize.BrickColor(Value)
	return BrickColor.new(Value.Name)
end
function Deserialize.CFrame(Value)
	for name,value in pairs(Value) do
		if typeof(name) == "string" then
			Value[name:upper()] = value
			Value[name] = nil
		end
	end
	return CFrame.new(Value.X, Value.Y, Value.Z, Value.R0, Value.R1, Value.R2, Value.R10, Value.R11, Value.R12,
		Value.R20, Value.R21, Value.R22)
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
