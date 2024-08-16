local module = {}

local rs = game:GetService("ReplicatedStorage")

local remoteFunctions = rs:FindFirstChild("RemoteFunctions")
local remoteEvents = rs:FindFirstChild("RemoteEvents")
local createObject = remoteFunctions and remoteFunctions:FindFirstChild("CreateObject")
local changeProperty = remoteEvents and remoteEvents:FindFirstChild("ObjectPropertyChangeRequested")
local insertToolbox = remoteFunctions and remoteFunctions:FindFirstChild("InsertContent")
local miscObjectInteraction = remoteEvents and remoteEvents:FindFirstChild("MiscObjectInteraction")

local hashlib = rs:FindFirstChild("HashLib")
hashlib = hashlib and require(hashlib)

function getCode()
	local clock = os.clock()
	return hashlib.md5(("\224\182\158%*\224\182\158"):format(clock)),clock
end

function module.createObj(className,parent)
	--[[if ClassName == "Part" then
		local part = InsertToolbox:InvokeServer("Brick","Models","Building",Vector3.zero)[1]
		spawn(function() if Parent then ChangeProperty:FireServer(part,"Parent",Parent) end end)
		return part,false
	else--]]
	local object
	repeat
		local v1,v2 = getCode()
		object = createObject:InvokeServer(className,parent,v1,v2)
	until object
	return object
	--end
end

function module.setProperty(object,property,value)
	changeProperty:FireServer(object,property,value)
end

function module.destroy(object)
	if typeof(object) == "Instance" then object={object} end
	miscObjectInteraction:FireServer(object,"Destroy")
end

return module
