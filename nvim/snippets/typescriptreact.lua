local ls = require('luasnip')
local s = ls.snippet
local i = ls.insert_node
local extras = require('luasnip.extras')
local l = extras.lambda
local fmt = require('luasnip.extras.fmt').fmt
local f = ls.function_node
local d = ls.dynamic_node
local t = ls.text_node
local sn = ls.snippet_node
local rep = require("luasnip.extras").rep

local log = function(message)
    local log_file_path = './comp.log'
    local log_file = io.open(log_file_path, "a")
    io.output(log_file)
    io.write(message .. "\n")
    io.close(log_file)
end

-- Get a list of  the property names given an `type_alias_declaration`
-- treesitter *tsx* node.
-- Ie, if the treesitter node represents:
--   type = {
--     prop1: string;
--     prop2: number;
--   }
-- Then this function would return `{"prop1", "prop2"}
---@param id_node {} Stands for "type_alias_declaration node"
---@return string[]
local function get_prop_names(id_node)
    local object_type_node = id_node:child(3)
    if object_type_node:type() ~= "object_type" then
        return {}
    end

    local prop_names = {}

    for prop_signature in object_type_node:iter_children() do
        if prop_signature:type() == "property_signature" then
            local prop_iden = prop_signature:child(0)
            local prop_name = vim.treesitter.query.get_node_text(prop_iden, 0)
            prop_names[#prop_names + 1] = prop_name
        end
    end

    return prop_names
end

return {
    s(
        { trig = 'uses', dscr = 'Use state' },
        fmt('const [{}, set{setter}] = useState({});', {
            i(1, 'value'),
            i(2, ''),
            setter = l(l._1:sub(1, 1):upper() .. l._1:sub(2, -1), 1)
        })
    ),
    s(
        { trig = 'compp', dscr = 'Component with parameters' },
        fmt([[
type {}Props = {{
    {}
}}

export const {} = ({{{}}}: {}Props): JSX.Element => {{
    {}

    return (
        {}
    );
}};
]]       , {
            d(1, function(_, snip)
                return sn(nil, {
                    t(vim.fn.substitute(snip.env.TM_FILENAME, "\\..*$", "", "g")),
                })
            end, {}),
            i(2, '// props'),
            rep(1),
            f(function(_, snip, _)
                local pos_begin = snip.nodes[2].mark:pos_begin()
                local pos_end = snip.nodes[2].mark:pos_end()
                local parser = vim.treesitter.get_parser(0, "tsx")
                local tstree = parser:parse()
                local node = tstree[1]
                    :root()
                    :named_descendant_for_range(pos_begin[1], pos_begin[2], pos_end[1], pos_end[2])

                while node ~= nil and node:type() ~= "type_alias_declaration" do
                    node = node:parent()
                end

                if node == nil then
                    return ""
                end

                local prop_names = get_prop_names(node)

                return vim.fn.join(prop_names, ", ")
            end, { 2 }),
            rep(1),
            i(3, ''),
            i(0, '<div>LOL</div>'),
        }
        )
    ),
}
