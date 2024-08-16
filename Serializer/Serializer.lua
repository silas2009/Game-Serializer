local module = {modules={},["settings"]={}}

local http = game:GetService("HttpService")

module.settings.blacklist = {"Terrain","Camera","TouchTransmitter"}
module.settings.allowedServices = {"Workspace","Lighting","StarterGui","StarterPack","Teams","SoundService"}

module.modules.properties = require(script.Properties)
local props = module.modules.properties.Properties
local InstanceProps = module.modules.properties.InstanceProperties
module.modules.scriptSerializer = require(script.ScriptSerializer)
module.modules.values = {
	valueSerializer = require(script.Values.ValueSerializer),
	valueDeserializer = require(script.Values.ValueDeserializer)
}
module.modules.textures = {
	surfaceTextures = require(script.Textures.RetroStudioSurfaceTextures),
	materialTextures = require(script.Textures.RetroStudioMaterialTextures)
}
module.modules.util = {
	guis = require(script.Util.GUIs),
	building = require(script.Util.Building),
	functions = require(script.Util.Functions)
}
module.modules.resources = {
	classIcons = require(script.Resources.ClassIcons),
	classWhitelist = require(script.Resources.ClassWhitelist)
}

local convertId = module.modules.util.functions.convertId
local build = module.modules.util.building

function module.Serialize(Object,json)
	local defaultProperties = {}
	local objs
	if Object == game then
		objs = {}
		for i,v in pairs(module.settings.allowedServices) do
			local service = game:GetService(v)
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
			for _,data in pairs(module.modules.textures.surfaceTextures) do
				if data.Texture == v.Texture then
					table.insert(fakeSurfaces,v)
					local part = {Part = v.Parent}
					part[v.Face.Name .. "Surface"] = data.Surface
					table.insert(partsWithSurfaces,part)
					break
				end
			end
			for _,data in pairs(module.modules.textures.materialTextures) do
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
		if not table.find(module.settings.blacklist,v.ClassName) and not table.find(fakeSurfaces,v) and not table.find(blackListedObjs,v) then
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
						local Function = module.modules.values.valueSerializer[typeof(v[propName])]
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
						local Function = module.modules.values.valueSerializer[typeof(objProperty)]
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
				if prop == "Parent" and realObj[prop].Parent == game and table.find(module.settings.allowedServices,realObj[prop].ClassName) then
					v[prop].Instance = realObj[prop].ClassName
				end
			end
		end
	end

	if json then
		objsSerialized = http:JSONEncode(objsSerialized)
	end
	return objsSerialized
end

function module.Deserialize(serialized,updateFunction)
	if typeof(serialized) == "string" then serialized = http:JSONDecode(serialized) end

	local exportFolder = build.createObj("Folder", game:GetService("Lighting"))
	build.setProperty(exportFolder,"Name","Export")
	local unparentedFolder = build.createObj("Folder", exportFolder)
	build.setProperty(unparentedFolder,"Name","Unparented")

	local instances = {}

	for id,v in ipairs(serialized) do
		local success,instance = pcall(function()
			return build.createObj(v.ClassName, unparentedFolder)
		end)
		if success and instance then
			if updateFunction then
				updateFunction(id,#serialized,"Building")
			end
			instances[tostring(id)] = instance
		end
	end

	for id,v in pairs(serialized) do
		if instances[tostring(id)] then
			local instance = instances[tostring(id)]
			if updateFunction then
				updateFunction(id,#serialized,"Setting properties")
			end
			pcall(function()
				if instance:IsA("BasePart") then
					build.setProperty(instance,"FormFactor","Custom")
				end
			end)
			for propName,propValue in pairs(v) do
				pcall(function()
					if typeof(propValue) == "table" then
						if propValue.Type ~= "Instance" then
							local valueFunction = module.modules.values.valueDeserializer[propValue.Type]
							if valueFunction then
								build.setProperty(instance,propName,valueFunction(propValue))
							end
						else
							if typeof(propValue.Instance) == "number" then
								local otherInstance = instances[tostring(propValue.Instance)]
								if not otherInstance and propName == "Parent" then
									build.setProperty(instance,"Parent",exportFolder)
								else
									build.setProperty(instance,propName,otherInstance)
								end
							elseif typeof(propValue.Instance) == "string" then
								local otherInstance = exportFolder
								if otherInstance then
									build.setProperty(instance,propName,otherInstance)
								end
							end
							if not instance.Parent then
								build.setProperty(instance,"Parent",exportFolder)
							end
						end
					else
						build.setProperty(instance,propName,propValue)
					end
				end)
			end
		end
	end

	return exportFolder
end

return module
