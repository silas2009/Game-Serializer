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

function module.deSerializeScript(Object,ScriptString)
	local Script = codeToTable(ScriptString)
	Script.Object = Object
	openScript:InvokeServer(Script.Object)
	local done = false
	
	local amount = 0
	for i,v in pairs(Script.Blocks) do
		amount += amount
	end
	local current = 0
	for blockName,block in pairs(Script.Blocks) do
		current += 1
		spawn(function()
			createBlock:InvokeServer(Script.Object,block.Type,blockName)
			for InputName,InputData in pairs(block.Inputs) do
				if InputData.UseVariable then
					setVariableInput:InvokeServer(Script.Object,blockName,InputName,InputData.Variable)
				else
					setValueInput:InvokeServer(Script.Object,blockName,InputName,InputData.Value)
				end
			end
			for OutputName,OutputValue in pairs(block.Outputs) do
				setOutputName:InvokeServer(Script.Object,blockName,OutputName,OutputValue)
			end
			if current == amount then
				done = true
			end
		end)
	end
	spawn(function()
		repeat task.wait() until done
		saveScript:InvokeServer(Script)
	end)
end

return module
