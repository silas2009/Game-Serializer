local module = {}

-- Services
local rs = game:GetService("ReplicatedStorage")

-- variables
local link = "https://raw.githubusercontent.com/silas2009/Game-Serializer/main/"
local classWhitelist = loadstring(game:HttpGet(link .. "Serializer/Resources/ClassWhitelist.lua"))()

local remotes = rs:FindFirstChild("Remotes")
if not remotes then return end
-- remotes events/functions
local remoteEvents = rs:FindFirstChild("RemoteEvents")
local createObject = remotes:FindFirstChild("CreateObject")
local changeProperty = remotes:FindFirstChild("ObjectPropertyChangeRequested")
local insertToolbox = remotes:FindFirstChild("InsertContent")
local miscObjectInteraction = remotes:FindFirstChild("MiscObjectInteraction")

local hashlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Egor-Skriptunoff/pure_lua_SHA/refs/heads/master/sha2.lua"))()

function getCode()
	local clock = os.clock()
	return hashlib.md5(("\224\182\158%*\224\182\158"):format(clock)),clock
end

function module.createObj(className,parent,cloneMethod,cloneResources,clonesUsed)
	if cloneMethod then
		for _,v in pairs(cloneResources:GetChildren()) do
			if v.ClassName == className and not table.find(clonesUsed,v) then
				module.setProperty(v,"Parent",parent)
				return v
			end
		end
	else
		local object
		repeat
			local v1,v2 = getCode()
			object = createObject:InvokeServer(className,parent,v1,v2)
		until object
		return object
	end
end

function module.setProperty(object,property,value)
	changeProperty:FireServer(object,property,value)
end

function module.destroy(object)
	if typeof(object) == "Instance" then object={object} end
	miscObjectInteraction:FireServer(object,"Destroy")
end

function module.clone(object,amount)
	if typeof(object) == "Instance" then
		local list = {}
		for i=1,amount or 1 do
			table.insert(list,object)
		end
		object = list
	end
	miscObjectInteraction:FireServer(object,"Duplicate")
end

function module.createCloneResources(objects)
	local resourceFolder = module.createObj("Folder",game:GetService("Lighting"))
	module.setProperty(resourceFolder,"Name","_CloneResources")
	local classes = {}
	local total = 0
	for _,object in pairs(objects) do
		if table.find(classWhitelist,object.ClassName) then
			if classes[object.ClassName] then
				classes[object.ClassName] += 1
			else
				classes[object.ClassName] = 1
			end
			total += 1
		end
	end
	for className,amount in pairs(classes) do
		local clone = module.createObj(className,resourceFolder)
		module.clone(clone,amount-1)
		task.wait(1)
	end
	return resourceFolder,classes,total
end

return module
