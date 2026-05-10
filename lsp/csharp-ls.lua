local blink_caps = require("blink.cmp").get_lsp_capabilities()

return {
    cmd = { "csharp-ls" },
    root_markers = { ".git", "*.sln", "*.csproj" },
    filetypes = { 'cs' },
    init_options = {
        AutomaticWorkspaceInit = true,
    },
    capabilities = blink_caps,
}
