local functions = {}
function functions.recurseTable(tbl,func)
	spawn(function()
		for index, value in pairs(tbl) do
			if typeof(value) == "table" then
				functions.recurseTable(value,func)
			else
				func(index,value)
			end
		end
	end)
end

return functions
