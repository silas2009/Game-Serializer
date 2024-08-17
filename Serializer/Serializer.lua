local module = {modules={},["settings"]={}}

local http = game:GetService("HttpService")

module.settings.blacklist = {"Terrain","Camera","TouchTransmitter"}
module.settings.allowedServices = {"Workspace","Lighting","StarterGui","StarterPack","Teams","SoundService"}

local githubLink = "https://raw.githubusercontent.com/silas2009/Game-Serializer/main/Serializer/"

module.modules.properties = loadstring(game:HttpGet(githubLink .. "Properties.lua"))()
local props = module.modules.properties.Properties
local InstanceProps = module.modules.properties.InstanceProperties
--module.modules.scriptSerializer = loadstring(game:HttpGet(githubLink .. "ScriptSerializer.lua"))()
module.modules.values = {
	valueSerializer = loadstring(game:HttpGet(githubLink .. "Values/ValueSerializer.lua"))(),
	valueDeserializer = loadstring(game:HttpGet(githubLink .. "Values/ValueDeserializer.lua"))(),
}
module.modules.textures = {
	surfaceTextures = loadstring(game:HttpGet(githubLink .. "Textures/RetroStudioSurfaceTextures.lua"))(),
	materialTextures = loadstring(game:HttpGet(githubLink .. "Textures/RetroStudioMaterialTextures.lua"))()
}
module.modules.util = {
	guis = loadstring(game:HttpGet(githubLink .. "Util/GUIs.lua"))(),
	building = loadstring(game:HttpGet(githubLink .. "Util/Building.lua"))(),
	functions = loadstring(game:HttpGet(githubLink .. "Util/Functions.lua"))()
}
module.modules.resources = {
	classIcons = loadstring(game:HttpGet(githubLink .. "Resources/ClassIcons.lua"))(),
	classWhitelist = loadstring(game:HttpGet(githubLink .. "Resources/ClassWhitelist.lua"))()
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
	
	local playerGui = game:GetService("Players").LocalPlayer:FindFirstChildOfClass("PlayerGui")
	local retrostudioUI = playerGui:FindFirstChild("StudioGui")
	if retrostudioUI then
		retrostudioUI:Destroy()
	end
	task.wait(2)
	
	local clonesUsed = {}
	local cloneResources = module.modules.util.building.createCloneResources(serialized)

	local exportFolder = build.createObj("Folder", game:GetService("Lighting"))
	build.setProperty(exportFolder,"Name","Export")
	local unparentedFolder = build.createObj("Folder", exportFolder)
	build.setProperty(unparentedFolder,"Name","Unparented")

	local instances = {} 
	
	for id,v in ipairs(serialized) do
		if table.find(module.modules.resources.classWhitelist,v.ClassName) then
			local success,instance = pcall(function()
				local obj = build.createObj(v.ClassName, unparentedFolder, true, cloneResources, clonesUsed)
				table.insert(clonesUsed,obj)
				return obj
			end)
			if success and instance then
				if updateFunction then
					updateFunction(id,#serialized,("Building %s \"%s\""):format(v.ClassName,v.Name or v.ClassName))
				end
				instances[tostring(id)] = instance
			end
			if not success then
				warn(instance)
			end
		end
	end
	
	repeat task.wait() until #cloneResources:GetChildren() == 0
	
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
	
	local retrostudioUI = game:GetService("StarterGui"):FindFirstChild("StudioGui")
	if retrostudioUI then
		retrostudioUI:Clone().Parent = playerGui
	end
	
	module.modules.util.building.destroy(cloneResources)

	return exportFolder
end

return module
