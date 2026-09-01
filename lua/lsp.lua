local lsps = {
    { "clangd" },
    { "bashls" },
    { "lua_ls" },
    { "rust-analyzer" },
    { "neocmakelsp" },
    { "csharp-ls"},
    { "python-lsp-server" },
}

-- Setup neocmake
local blink_caps = require("blink.cmp").get_lsp_capabilities()

vim.lsp.config("neocmakelsp", {
    cmd = { "neocmakelsp", "--stdio" },
    filetypes = { "cmake" },
    root_markers = { ".git", "build", "CMakeLists.txt"},
    capabilities = blink_caps,
})

vim.lsp.config("neocmakelsp", {
    capabilities = blink_caps
})

vim.diagnostic.config({ virtual_text = true })

for _, lsp in pairs(lsps) do
    local name, config = lsp[1], lsp[2]
    vim.lsp.enable(name)
    if config then
        vim.lsp.config(name, config)
    end
end
