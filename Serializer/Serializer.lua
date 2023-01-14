local module = {}

local blacklist = {
	"Terrain",
	"Camera"
}

local props = require(script.Properties).Properties
local InstanceProps = require(script.Properties).InstanceProperties
local SerializeValues = require(script.SerializeValues)

function module.Serialize(Object)
	local start = tick()
	local objs = Object:GetDescendants()
	local objsSerialized = {}
	if Object.Parent ~= game then
		table.insert(objs,Object)
	end
	local objTable = {}
	for _,v in ipairs(objs) do
		if not table.find(blacklist,v.ClassName) then
			local objSerialized = {}
			local classProp = props[v.ClassName]
			if classProp then
				for _,prop in pairs(classProp) do
					local Function = SerializeValues[typeof(v[prop])]
					if Function then
						objSerialized[prop] = Function(v[prop])
					else
						objSerialized[prop] = v[prop]
					end
					if typeof(objSerialized[prop]) == "string" and objSerialized[prop]:sub(1,32) == "http://www.roblox.com/asset/?id=" then
						objSerialized[prop] = "rbxassetid://" .. string.sub(objSerialized[prop],33,string.len(objSerialized[prop]))
					end
				end
			end
			for _,prop in pairs(props.Instance) do
				local Function = SerializeValues[typeof(v[prop])]
				if Function then
					objSerialized[prop] = Function(v[prop])
				else
					objSerialized[prop] = v[prop]
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
			end
		end
		for _,prop in pairs(InstanceProps.Instance) do
			local foundObj = table.find(objTable,realObj[prop])
			v[prop] = {Type = "Instance", ["Instance"] = foundObj}
		end
	end
	print("time took: " .. tick() - start)
	return objsSerialized
end

return module
