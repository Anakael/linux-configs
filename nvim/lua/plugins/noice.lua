local setup = function()
    require("noice").setup({
        lsp = {
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
            signature = {
                enabled = false
            }
        },
        presets = {
            long_message_to_split = true,
            lsp_doc_border = false,
        },
        routes = {
            {
                filter = {
                    event = "msg_show",
                    kind = "",
                    find = "written",
                },
                opts = { skip = true },
            },
            {
                filter = {
                    event = "msg_show",
                    kind = "",
                    find = "before #",
                },
                opts = { skip = true },
            },
        },
        views = {
            cmdline_popup = {
                border = {
                    style = "none",
                    padding = { 1, 2 },
                },
                filter_options = {},
                win_options = {
                    winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
                },
            },
        },
    })
end

local M = {
    setup = setup
}

return M
