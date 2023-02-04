local ls = require('luasnip')
local s = ls.snippet
local f = ls.f
local fmt = require('luasnip.extras.fmt').fmt
local path = require('plenary').path

function string:endswith(ending)
    return ending == "" or self:sub(- #ending) == ending
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
                    if namespaces_cache[closest_csproj] ~= nil then
                        root_namespace = namespaces_cache[closest_csproj]
                    else
                        local csproj_data = path.new(dir):joinpath(name):read()
                        local root_namespace_from_file = string.match(csproj_data, "<RootNamespace>(.+)</RootNamespace>")
                        if root_namespace_from_file ~= nil then
                            root_namespace = root_namespace_from_file
                        end
                    end
                    namespaces_cache[closest_csproj] = root_namespace

                    if root_namespace ~= "" then
                        root_namespace = root_namespace .. "."
                    end
                    local file_path = vim.fn.fnamemodify(vim.fn.expand('%:r'), ':h')
                    local relative_path = file_path:gsub('.*' .. closest_csproj:gsub('%.', '%.'), '')
                    local namespace = root_namespace .. (closest_csproj .. relative_path):gsub(path.path.sep, '%.')
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
