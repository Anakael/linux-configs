local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt

local function get_ns()
	local filename = vim.api.nvim_buf_get_name(0)
	for dir in vim.fs.parents(filename) do
		local project, solution
		for name, kind in vim.fs.dir(dir) do
			if kind == "file" then
				if name:match("%.csproj$") then
					project = project or name
				elseif name:match("%.slnx?$") then
					solution = true
				end
			end
		end

		-- A project takes priority over a solution in the same directory.
		if project then
			local project_name = project:sub(1, -8)
			local data = table.concat(vim.fn.readfile(vim.fs.joinpath(dir, project)), "\n")
			local namespace = data:match("<RootNamespace>%s*(.-)%s*</RootNamespace>") or project_name
			-- ponytail: direct properties only; use MSBuild evaluation if imports/conditions are needed.
			namespace = namespace:gsub("%$%(([%w_]+)%)", function(property)
				if property == "MSBuildProjectName" then
					return project_name
				end
				return data:match("<" .. property .. ">%s*(.-)%s*</" .. property .. ">")
			end)
			local relative_dir = vim.fs.relpath(dir, vim.fs.dirname(filename)):gsub("[/\\]", ".")
			if relative_dir ~= "." then
				return namespace == "" and relative_dir or namespace .. "." .. relative_dir
			end
			return namespace
		elseif solution then
			return ""
		end
	end
	return ""
end

return {
	ls.snippet({ trig = "ns", dscr = "Namespace" }, fmt("namespace {};", { ls.f(get_ns, {}) })),
}
