local ls = require('luasnip')
local s = ls.snippet
local f = ls.f
local fmt = require('luasnip.extras.fmt').fmt
local path = require('plenary').path

function string:endswith(ending)
    return ending == "" or self:sub(- #ending) == ending
end

function string:expand_vars(csproj_data)
    local template = "$%((.+)%)"
    local var_to_expand = self:match(template)
    if var_to_expand == nil then
        return self
    end

    local var_value = string.match(csproj_data, "<" .. var_to_expand .. ">(.+)</" .. var_to_expand .. ">")
    return self:gsub(template, var_value)
end

local namespaces_cache = {}

local function get_ns()
    for dir in vim.fs.parents(vim.api.nvim_buf_get_name(0)) do
        for name, type in vim.fs.dir(dir) do
            if type == 'file' then
                if name:endswith('.sln') then
                    return ''
                end
                local closest_csproj = string.match(name, '(.*)%.csproj')
                if closest_csproj ~= nil then
                    local root_namespace = ""
                    local root_namespace_mayble_cache = namespaces_cache[closest_csproj]
                    if root_namespace_mayble_cache ~= nil then
                        root_namespace = root_namespace_mayble_cache
                    else
                        local csproj_data = path.new(dir):joinpath(name):read()
                        local root_namespace_from_file = string.match(csproj_data, "<RootNamespace>(.+)</RootNamespace>")
                        if root_namespace_from_file ~= nil then
                            root_namespace = root_namespace_from_file:expand_vars(csproj_data)
                        end
                    end
                    namespaces_cache[closest_csproj] = root_namespace

                    local file_path = vim.fn.fnamemodify(vim.fn.expand('%:r'), ':h')
                    if root_namespace ~= "" then
                        file_path = file_path:gsub('.*' .. closest_csproj:gsub('%.', '%.'), '')
                    end
                    local namespace = root_namespace .. file_path:gsub(path.path.sep, '%.')
                    return namespace
                end
            end
        end
    end
end

return {
    s(
        { trig = 'ns', dscr = 'Namespace' },
        fmt('namespace {};', {
            f(get_ns, {})
        })
    ),
}
