-- Run from the config directory: nvim --clean --headless -l tests/config.lua
local root = vim.fn.getcwd()
local tmp = vim.fn.tempname()
local original_buffer = vim.api.nvim_get_current_buf()
local buffer = vim.api.nvim_create_buf(false, true)
vim.api.nvim_set_current_buf(buffer)

-- Capture the namespace callback without requiring third-party plugins.
package.preload["luasnip"] = function()
	return { snippet = function(_, body) return body end, f = function(fn) return fn end }
end
package.preload["luasnip.extras.fmt"] = function()
	return { fmt = function(_, nodes) return nodes end }
end
local namespace = dofile(root .. "/snippets/cs.lua")[1][1]
local function write(path, lines)
	vim.fn.mkdir(vim.fs.dirname(path), "p")
	vim.fn.writefile(lines, path)
end
local function check(path, expected)
	vim.api.nvim_buf_set_name(buffer, tmp .. "/" .. path)
	assert(namespace() == expected, path .. ": expected " .. expected .. ", got " .. namespace())
end

local ok, err = pcall(function()
	write(tmp .. "/App/My.Product.csproj", { "<Project></Project>" })
	vim.fn.mkdir(tmp .. "/App/Features/Nested", "p")
	check("App/Features/Nested/File.cs", "My.Product.Features.Nested")
	check("App/File.cs", "My.Product")
	write(tmp .. "/App/My.Product.csproj", {
		"<Project>", "<RootNamespace> Custom.Root </RootNamespace>", "</Project>",
	})
	check("App/Features/File.cs", "Custom.Root.Features")
	write(tmp .. "/Other/My.Product.csproj", { "<RootNamespace>Other.Root</RootNamespace>" })
	check("Other/File.cs", "Other.Root")
	write(tmp .. "/App/My.Product.csproj", {
		"<Company>Acme</Company>", "<RootNamespace>$(Company).$(MSBuildProjectName)</RootNamespace>",
	})
	check("App/File.cs", "Acme.My.Product")
	write(tmp .. "/App/My.Product.csproj", { "<RootNamespace></RootNamespace>" })
	check("App/Features/File.cs", "Features")
	for _, extension in ipairs({ "sln", "slnx" }) do
		write(tmp .. "/App/Solution." .. extension, {})
		check("App/Features/File.cs", "Features") -- Project wins in the same directory.
		write(tmp .. "/App/Boundary/Solution." .. extension, {})
		check("App/Boundary/File.cs", "") -- Do not escape the solution boundary.
	end
	check("NoProject/File.cs", "")
	assert(string.expand_vars == nil and string.endswith == nil, "Do not modify the string library")

	for _, file in ipairs(vim.fn.glob(root .. "/**/*.lua", false, true)) do
		assert(loadfile(file))
	end
	for _, file in ipairs(vim.fn.glob(root .. "/lua/plugins/*.lua", false, true)) do
		for _, spec in ipairs(dofile(file)) do
			if type(spec) == "table" then
				for _, key in ipairs(spec.keys or {}) do
					assert(key.desc, file .. ": missing desc for " .. key[1])
				end
			end
		end
	end
	local requested, installed = {}, {}
	package.preload["mason"] = function() return { setup = function() end } end
	package.preload["mason-registry"] = function()
		return {
			refresh = function(callback) callback(true) end,
			get_package = function(name)
				requested[name] = true
				return {
					is_installed = function() return name == "stylua" end,
					is_installing = function() return name == "prettierd" end,
					install = function() installed[name] = true end,
				}
			end,
		}
	end
	dofile(root .. "/lua/plugins/lsp.lua")[1].config(nil, {})
	assert(requested.stylua and requested.prettierd and requested.eslint_d and requested.csharpier)
	assert(not installed.stylua and not installed.prettierd)
	assert(installed.eslint_d and installed.csharpier)
	local manifest = vim.json.decode(table.concat(vim.fn.readfile(root .. "/snippets/package.json"), "\n"))
	for _, entry in ipairs(manifest.contributes.snippets) do
		assert(vim.fn.filereadable(root .. "/snippets/" .. entry.path) == 1, entry.path)
	end
end)
vim.api.nvim_set_current_buf(original_buffer)
vim.api.nvim_buf_delete(buffer, { force = true })
vim.fn.delete(tmp, "rf")
assert(ok, err)
print("PASS: namespaces, sln/slnx, Lua syntax, key descriptions, formatter installation, snippet manifest")
