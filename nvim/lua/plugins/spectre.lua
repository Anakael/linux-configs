local setup = function()
	local spectre = require("spectre")

	spectre.setup({
		default = {
			replace = {
				cmd = "sd",
			},
		},
	})
end

local M = {
	setup = setup,
}

return M
