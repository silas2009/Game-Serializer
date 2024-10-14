local module = {}

local link = "https://raw.githubusercontent.com/silas2009/Game-Serializer/main/"
local dsvalue = loadstring(game:HttpGet(link .. "Serializer/Values/ValueDeserializer.lua"))()
local svalue = loadstring(game:HttpGet(link .. "Serializer/Values/ValueSerializer.lua"))()

local partClasses = {
	"Part",
	"WedgePart",
	"VehicleSeat",
	"SpawnLocation",
	"Seat",
	"CornerWedgePart",
	"FlagStand"
}

function module.convertId(url)
	local id 
	url = url:lower()
	if url:sub(1,7) == "http://" then
		id = url:sub(8,#url)
	elseif url:sub(1,8) == "https://" then
		id = url:sub(9,#url)
	end
	if not id then return url end
	id = id:split("/")
	if id[2] == "asset" and id[3] and id[3]:sub(1,4) == "?id=" then
		id = id[3]:sub(5,#id[3])
	elseif id[2] and id[2]:sub(1,9) == "asset?id=" then
		id = id[2]:sub(10,#id[2])
	end
	if typeof(id) ~= "string" then return url end
	return "rbxassetid://" .. id
end

function module.getTrueSize(id,object,serialized)
	local className = object.ClassName
	if table.find(partClasses,className) then
		local size = object.Size and dsvalue.Vector3(object.Size) or Vector3.new(4, 1.2, 2)
		local _size = size
		local truesize = size
		local mesh
		if className == "Part" then
			local shape = object.Shape and object.Shape.Name or "Block"
			if shape == "Block" then
				truesize = Vector3.new(math.clamp(truesize.X,0.2,math.huge),math.clamp(truesize.Y,0.2,math.huge),math.clamp(truesize.Z,0.2,math.huge))
				mesh = Instance.new("BlockMesh")
			elseif shape == "Cylinder" or shape == "Ball" then
				local sizes = {truesize.X,truesize.Y,truesize.Z}
				table.sort(sizes,function(a,b) return a>b end)
				_size = Vector3.new(sizes[1],sizes[1],sizes[1])
				if truesize ~= _size then
					object.Shape.Name = "Block"
					truesize = Vector3.new(math.clamp(truesize.X,0.2,math.huge),math.clamp(truesize.Y,0.2,math.huge),math.clamp(truesize.Z,0.2,math.huge))
				end
				mesh = Instance.new("SpecialMesh")
				mesh.MeshType = (shape == "Cylinder" and Enum.MeshType.Cylinder) or (shape == "Ball" and Enum.MeshType.Sphere)
			end
		else
			truesize = Vector3.new(math.clamp(truesize.X,0.2,math.huge),math.clamp(truesize.Y,0.2,math.huge),math.clamp(truesize.Z,0.2,math.huge))
		end
		if className == "WedgePart" then
			mesh = Instance.new("SpecialMesh")
			mesh.MeshType = Enum.MeshType.Wedge
		elseif className == "CornerWedgePart" then
			mesh = Instance.new("SpecialMesh")
			mesh.MeshType = Enum.MeshType.CornerWedge
		elseif className == "VehicleSeat" or className == "SpawnLocation" or className == "Seat" or className == "FlagStand" then
			mesh = Instance.new("BlockMesh")
		end
		mesh = truesize ~= _size and mesh or nil
		if mesh then
			mesh.Scale = size/truesize
		end
		for _,obj in pairs(serialized) do
			if obj.ClassName == "SpecialMesh" or obj.ClassName == "BlockMesh" or obj.ClassName == "CylinderMesh" then
				if obj.Parent.Instance == id then
					mesh = nil
					if truesize ~= _size then
						if (obj.ClassName == "SpecialMesh" and not (obj.MeshType and obj.MeshType.Name == "FileMesh")) or obj.ClassName ~= "SpecialMesh" then
							local scale = dsvalue.Vector3(obj.Scale)
							obj.Scale = svalue.Vector3((size/truesize)*scale)
						end
					end
				end
			end
		end
		return truesize,mesh
	end
end

return module
