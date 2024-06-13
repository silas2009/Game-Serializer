local module = {}

local blacklist = {
	"Terrain","Camera","TouchTransmitter"
}

local AllowedServices = {
	"Workspace","Lighting","StarterGui","StarterPack","Teams","SoundService"
}

local propsTable = loadstring(game:HttpGet("https://raw.githubusercontent.com/silas2009/Game-Serializer/main/Serializer/Properties.lua"))()
local props = propsTable.Properties
local InstanceProps = propsTable.InstanceProperties
local SerializeValues = loadstring(game:HttpGet("https://raw.githubusercontent.com/silas2009/Game-Serializer/main/Serializer/Values/ValueSerializer.lua"))()
local TextureSurfaces = loadstring(game:HttpGet("https://raw.githubusercontent.com/silas2009/Game-Serializer/main/Serializer/Textures/RetroStudioSurfaceTextures.lua"))()
local TextureMaterials = loadstring(game:HttpGet("https://raw.githubusercontent.com/silas2009/Game-Serializer/main/Serializer/Textures/RetroStudioMaterialTextures.lua"))()

function convertId(assetId)
    local starts = {
        "http://www.roblox.com/asset?id="
    }
    for i,v in pairs(starts) do
        if string.sub(assetId,0,#v) == v then
            return "rbxassetid://" .. string.sub(assetId,#v+1,#assetId)
        end
    end
    return assetId
end

function module.Serialize(Object,json)
	local defaultProperties = {}
	local objs
	if Object == game then
		objs = {}
		for i,v in pairs(AllowedServices) do
			service = game:GetService(v)
			if service then
				for _,obj in pairs(service:GetDescendants()) do
					table.insert(objs,obj)
				end
			end
		end
	else
		objs = Object:GetDescendants()
	end
	local objsSerialized = {}
	if Object ~= game and Object.Parent ~= game then
		table.insert(objs,Object)
	end
	local objTable = {}
	local fakeSurfaces = {}
	local partsWithSurfaces = {}
	for _,v in ipairs(objs) do
		if v:IsA("Texture") or v:IsA("Decal") then
			for _,data in pairs(TextureSurfaces) do
				if data.Texture == v.Texture then
					table.insert(fakeSurfaces,v)
					local part = {Part = v.Parent}
					part[v.Face.Name .. "Surface"] = data.Surface
					table.insert(partsWithSurfaces,part)
					break
				end
			end
			for _,data in pairs(TextureMaterials) do
				if data.Texture == v.Texture then
					if not table.find(fakeSurfaces,v) then
						table.insert(fakeSurfaces,v)
					end
					break
				end
			end
		end
	end
	local blackListedObjs = {}
	for _,v in ipairs(objs) do
		if not table.find(blacklist,v.ClassName) and not table.find(fakeSurfaces,v) and not table.find(blackListedObjs,v) then
			local objSerialized = {}
			local classProp = props[v.ClassName]
			if classProp then
				local surfaceobj
				if v:IsA("BasePart") then
					for _,v2 in pairs(partsWithSurfaces) do
						if v2.Part == v then
							surfaceobj = v2
							surfaceobj["Part"] = nil
						end
					end
				end
				if surfaceobj then
					for propName,prop in pairs(surfaceobj) do
						local Function = SerializeValues[typeof(v[propName])]
						if Function then
							objSerialized[propName] = Function(prop)
						else
							objSerialized[propName] = prop
						end
					end
				end
				for _,prop in pairs(classProp) do
					if not objSerialized[prop] then
						local defaultValue = defaultProperties[v.ClassName]
						if not defaultValue then
							local success,defaultinst = pcall(function()
								return Instance.new(v.ClassName)
							end)
							if success then
								defaultProperties[v.ClassName] = defaultinst
								defaultValue = defaultinst
							end
						end
						defaultValue = defaultValue and defaultValue[prop]
						local objProperty = v[prop]
						if prop ~= "ClassName" and objProperty == defaultValue then
							continue
						end
						local Function = SerializeValues[typeof(objProperty)]
						if Function then
							objSerialized[prop] = Function(objProperty)
						else
							objSerialized[prop] = objProperty
						end
						if typeof(objSerialized[prop]) == "string" then
							objSerialized[prop] = convertId(objSerialized[prop])
						end
					end
				end
			end

			table.insert(objsSerialized,objSerialized)
			table.insert(objTable,v)
		end
	end
	for i,v in ipairs(objsSerialized) do
		local realObj = objTable[i]
		local classProp = InstanceProps[v.ClassName]
		if classProp then
			for _,prop in pairs(classProp) do
				local foundObj = table.find(objTable,realObj[prop])
				v[prop] = {Type = "Instance", ["Instance"] = foundObj}
				if prop == "Parent" and realObj[prop].Parent == game and table.find(AllowedServices,realObj[prop].ClassName) then
					v[prop].Instance = realObj[prop].ClassName
				end
			end
		end
	end
	
	if json then
		objsSerialized = game:GetService("HttpService"):JSONEncode(objsSerialized)
	end
	return objsSerialized
end

return module
