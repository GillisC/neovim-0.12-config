
return {
    cmd = { "rust-analyzer" },
    filetypes = { "rust" },
    capabilities = {
        experimental = {
            commands = {
                commands = { "rust-analyzer.showReferences", "rust-analyzer.runSingle", "rust-analyzer.debugSingle" }
            },
            serverStatusNotification = true
        }
    },
    root_markers = { ".git" }
}
