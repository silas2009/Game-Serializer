local Import = {}
function Import.Vector3(Value)
	return Vector3.new(Value.X, Value.Y, Value.Z)
end
function Import.EnumItem(Value)
	return Enum[Value.EnumType][Value.Name]
end
function Import.Color3(Value)
	return Color3.new(Value.R, Value.G, Value.B)
end
function Import.BrickColor(Value)
	return BrickColor.new(Value.Name)
end
function Import.CFrame(Value)
	return CFrame.new(Value.x, Value.y, Value.z, Value.r0, Value.r1, Value.r2, Value.r10, Value.r11, Value.r12,
		Value.r20, Value.r21, Value.r22)
end
function Import.UDim2(Value)
	return UDim2.new(Value.X.Scale,Value.X.Offset,Value.Y.Scale,Value.Y.Offset)
end
function Import.UDim(Value)
	return UDim.new(Value.Scale,Value.Offset)
end

return Import
