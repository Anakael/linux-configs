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
local c = ls.choice_node
local rep = require("luasnip.extras").rep

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
local get_prop_names = function(id_node)
    local object_type_node = id_node:child(3)
    if object_type_node:type() ~= "object_type" then
        return {}
    end

    local prop_names = {}

    for prop_signature in object_type_node:iter_children() do
        if prop_signature:type() == "property_signature" then
            local prop_iden = prop_signature:child(0)
            local prop_name = vim.treesitter.get_node_text(prop_iden, 0)
            prop_names[#prop_names + 1] = prop_name
        end
    end

    return prop_names
end

local filename_node = function(_, snip)
    return sn(nil, {
        t(snip.env.TM_FILENAME_BASE),
    })
end


return {
    s({ trig = 'comp', dscr = 'Component' },
        fmt([[
/** {}.
 * @returns Comp.
 */
export const {} = (): JSX.Element =>{}
]], {
            i(1),
            d(2, filename_node, {}),
            c(3, {
                sn(nil, fmt([[


                {};
                ]], { i(1, '    <>LOL</>') })),
                sn(nil, fmt([[ {{
    {}

    return (
        <>{}</>
    );
}};
                ]], {
                    i(1),
                    i(2, 'LOL')
                })),
            }),
        })),
    s({ trig = 'compp', dscr = 'Component with parameters' },
        fmt([[
/* Props. */
type {}Props = {{
    {}
}};

/**
 * {}.
 * @param {{{}Props}} props - Props.
 * @returns Comp.
 */
export const {} = ({{ {} }}: {}Props): JSX.Element => {{
    {}

    return (
        {}
    );
}};
]], {
            d(1, filename_node, {}),
            i(2, '// props'),
            i(3),
            rep(1),
            rep(1),
            f(function(_, snip, _)
                local pos_begin = snip.nodes[2].mark:pos_begin()
                local pos_end = snip.nodes[2].mark:pos_end()
                local parser = vim.treesitter.get_parser(nil, "tsx")
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
            i(4, ''),
            i(0, '<>LOL</>'),
        }
        )),
}
