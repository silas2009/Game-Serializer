return function recurseTable(tbl,func)
	spawn(function()
		for index, value in pairs(tbl) do
			if typeof(value) == "table" then
				recurseTable(value)
			else
				func(index,value)
			end
		end
	end)
end
