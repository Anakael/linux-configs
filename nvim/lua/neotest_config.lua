require('neotest').setup({
    adapters = {
        require('neotest-dotnet')({
            discovery_root = 'solution'
        })
    },
    quickfix = {
        enabled = true,
        open = false
    }
})
