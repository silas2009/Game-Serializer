local module = {}

local rs = game:GetService("ReplicatedStorage")
local ScriptService = game:GetService("ReplicatedStorage").ScriptService
local compression = require(ScriptService.Compression)
local converter = require(ScriptService.LoadModules:FindFirstChild("0000000000000001"))
local createBlock
local openScript
local saveScript
local setValueInput
local setVariableInput
local setOutputName
if game.PlaceId == 5846387555 then
	createBlock = rs.RemoteFunctions.ScriptEditor.CreateBlock
	openScript = rs.RemoteFunctions.ScriptEditor.OpenScript
	saveScript = rs.RemoteFunctions.ScriptEditor.ScriptSaveRequested
	setValueInput = rs.RemoteFunctions.ScriptEditor.SetValueInput
	setVariableInput = rs.RemoteFunctions.ScriptEditor.SetVariableInput
	setOutputName = rs.RemoteFunctions.ScriptEditor.SetOutputName
end
function codeToTable(Script)
	return converter(compression.decompress(Script))
end
function stringify(v, spaces, usesemicolon, depth)
	if type(v) ~= 'table' then
		return tostring(v)
	elseif not next(v) then
		return '{}'
	end

	spaces = spaces or 4
	depth = depth or 1

	local space = (" "):rep(depth * spaces)
	local sep = usesemicolon and ";" or ","
	local concatenationBuilder = {"{"}

	for k, x in next, v do
		table.insert(concatenationBuilder, ("\n%s[%s] = %s%s"):format(space,type(k)=='number'and tostring(k)or('"%s"'):format(tostring(k)), stringify(x, spaces, usesemicolon, depth+1), sep))
	end

	local s = table.concat(concatenationBuilder)
	return ("%s\n%s}"):format(s:sub(1,-2), space:sub(1, -spaces-1))
end

function module.deSerializeScript(Object,ScriptString)
	local Script = codeToTable(ScriptString)
	Script.Object = Object
	openScript:InvokeServer(Script.Object)
	local done = false

	local amount = 0
	for i,v in pairs(Script.Blocks) do
		amount += 1
	end
	local current = 0
	setclipboard(stringify(Script,_,false))
	for blockName,block in pairs(Script.Blocks) do
		print(blockName)
		createBlock:InvokeServer(Script.Object,block.Type,blockName)
		for InputName,InputData in pairs(block.Inputs) do
			print(InputName,InputData.Value,InputData.Variable)
			if InputData.Variable then
				InputData.Value = ""
				setVariableInput:InvokeServer(Script.Object,blockName,InputName,InputData.Variable)
			else
				InputData.Variable = ""
				setValueInput:InvokeServer(Script.Object,blockName,InputName,InputData.Value)
			end
			print("yeet")
		end
		for OutputName,OutputValue in pairs(block.Outputs) do
			setOutputName:InvokeServer(Script.Object,blockName,OutputName,OutputValue)
		end
		if current == amount then
			done = true
		end
	end
	saveScript:InvokeServer(Script)
end

return module
