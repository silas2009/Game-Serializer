rs = game:GetService("ReplicatedStorage")
local https = game:GetService("HttpService")
local runs = game:GetService("RunService")
local uis = game:GetService("UserInputService")
local ts = game:GetService("TweenService")
local players = game:GetService("Players")

local plr = players.LocalPlayer

local githubLink = "https://raw.githubusercontent.com/silas2009/Game-Serializer/main/"

local hashlib = rs:FindFirstChild("HashLib") and require(rs.HashLib)
local classWhitelist = loadstring(game:HttpGet(githubLink.."Serializer/Resources/ClassWhitelist.lua"))()
local deserializeValue = loadstring(game:HttpGet(githubLink.."Serializer/Values/ValueDeserializer.lua"))()
local serializeValue = loadstring(game:HttpGet(githubLink.."Serializer/Values/ValueSerializer.lua"))()

local remoteFunctions = rs:FindFirstChild("RemoteFunctions")
local remoteEvents = rs:WaitForChild("RemoteEvents")

-- remote functions / events
local CreateObject = remoteFunctions and remoteFunctions:FindFirstChild("CreateObject")
local ChangeProperty = remoteEvents and remoteEvents:FindFirstChild("ObjectPropertyChangeRequested")
local MiscObjectInteraction = remoteEvents and remoteEvents:WaitForChild("MiscObjectInteraction")

function getHash()
	local clock = os.clock()
	return hashlib.md5(("\224\182\158%*\224\182\158"):format(clock)),clock
end

function createObject(ClassName,Parent)
	if not table.find(classWhitelist,ClassName) then return end
	local object = nil
	repeat
		local v1,v2 = getHash()
		object = CreateObject:InvokeServer(ClassName,Parent or workspace,v1,v2)
	until object
	return object
end

function cloneObject(object, amount, parent)
	if amount <= 0 then return end
	local clones = {}
	for i = 1,amount do
		table.insert(clones,object)
	end
	MiscObjectInteraction:FireServer(clones,"Copy")
	MiscObjectInteraction:FireServer({parent or workspace},"Paste")
end

function changeObjectProperty(object, property, value)
	ChangeProperty:FireServer(object,property,value)
end

function getObjectOutOfFolder(folder,className,objectsChosen)
	local children = folder:GetChildren()
	if #children >= 1 then
		for i = 1,#children do
			local v = children[i]
			if v.ClassName == className and not table.find(objectsChosen,v) then
				table.insert(objectsChosen,v)
				return v,objectsChosen
			end
		end
	end
	return nil,objectsChosen
end

function deserialize(serialized)
	if typeof(serialized) == "string" then serialized = https:JSONDecode(serialized) end
	
	if plr.PlayerGui:FindFirstChild("StudioGui") then -- Disable Studio Gui
		plr.PlayerGui:FindFirstChild("StudioGui"):Destroy()
	end
	
	local exportFolder = createObject("Folder",game:GetService("SoundService"))
	changeObjectProperty(exportFolder,"Name","Export")
	local unparented = createObject("Folder",exportFolder)
	changeObjectProperty(unparented,"Name","Unparented")
	
	local instances = {}
	local classes = {}
	
	for id,obj in pairs(serialized) do
		if obj.ClassName and table.find(classWhitelist, obj.ClassName) then
			if not classes[obj.ClassName] then
				classes[obj.ClassName] = 1
			else
				classes[obj.ClassName] += 1
			end
		end
	end
	
	for className,amount in pairs(classes) do
		local object = createObject(className,unparented)
		cloneObject(object,amount - 1,unparented)
	end
	
	wait(1)
	local objsChosen = {}
	for id,v in ipairs(serialized) do
		local success,object,chosen = pcall(function()
			return getObjectOutOfFolder(unparented,v.ClassName,objsChosen)
		end)
		if success and object then
			instances[tostring(id)] = object
		end
		if chosen then
			objsChosen = chosen
		end
	end
	for id,v in ipairs(serialized) do
		if instances[tostring(id)] then
			local instance = instances[tostring(id)]
			pcall(function()
				if instance:IsA("BasePart") then
					changeObjectProperty(instance,"FormFactor","Custom")
				end
			end)
			for propName,propValue in pairs(v) do
				pcall(function()
					if typeof(propValue) == "table" then
						if propValue.Type ~= "Instance" then
							local valueFunction = deserializeValue[propValue.Type]
							if valueFunction then
								changeObjectProperty(instance,propName,valueFunction(propValue))
							end
						else
							if typeof(propValue.Instance) == "number" then
								local otherInstance = instances[tostring(propValue.Instance)]
								if not otherInstance and propName == "Parent" then
									changeObjectProperty(instance,"Parent",exportFolder)
								else
									changeObjectProperty(instance,propName,otherInstance)
								end
							elseif typeof(propValue.Instance) == "string" then
								local otherInstance = exportFolder
								if otherInstance then
									changeObjectProperty(instance,propName,otherInstance)
								end
							end
							if not instance.Parent then
								changeObjectProperty(instance,"Parent",exportFolder)
							end
						end
					else
						changeObjectProperty(instance,propName,propValue)
					end
				end)
			end
		end
	end
	if not plr.PlayerGui:FindFirstChild("StudioGui") then -- Enable Studio Gui
		game:GetService("StarterGui"):WaitForChild("StudioGui"):Clone().Parent = plr.PlayerGui
	end
end

return deserialize
