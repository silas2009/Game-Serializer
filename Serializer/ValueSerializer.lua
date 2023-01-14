local Serialize = {}
function Serialize.Vector3(Value:Vector3)
	return {Type = typeof(Value),X = Value.X, Y = Value.Y, Z = Value.Z}
end
function Serialize.EnumItem(Value:EnumItem)
	return {Type = typeof(Value),Name=Value.Name,EnumType=tostring(Value.EnumType)}
end
function Serialize.Color3(Value:Color3)
	return {Type = typeof(Value),R = Value.R, G = Value.G, B = Value.B}
end
function Serialize.BrickColor(Value:BrickColor)
	return {Type = typeof(Value),Name = Value.Name}
end
function Serialize.CFrame(Value:CFrame)
	local x, y, z, r0, r1, r2, r10, r11, r12, r20, r21, r22 = Value:components()
	return {Type = typeof(Value),x=x,y=y,z=z,r0=r0,r1=r1,r2=r2,r10=r10,r11=r11,r12=r12,r20=r20,r21=r21,r22=r22}
end
function Serialize.UDim2(Value:UDim2)
	return {
		Type = typeof(Value),
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
function Serialize.UDim(Value:UDim)
	return {
		Type = typeof(Value),
		Offset = Value.Offset,
		Scale = Value.Scale
	}
end

return Serialize
