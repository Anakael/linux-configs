return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"Issafalcon/neotest-dotnet",
			"nvim-neotest/nvim-nio",
		},
		opts = function()
			return {
				adapters = {
					require("neotest-dotnet")({
						discovery_root = "solution",
					}),
				},
				quickfix = {
					enabled = true,
					open = false,
				},
			}
		end,
		config = function(_, opts)
			require("neotest").setup(opts)

			local create_user_command = vim.api.nvim_create_user_command

			create_user_command("Test", function(args)
				neotest.run.run({ strategy = "integrated" })
			end, { nargs = "?" })

			create_user_command("TestStop", function()
				neotest.run.stop()
			end, {})

			create_user_command("TestSummary", function()
				neotest.summary.toggle()
			end, {})
		end,
	},
}
