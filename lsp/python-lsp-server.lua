return {
    cmd = { "python-lsp-server", "start" },
    filetypes = { "py" },
    root_markers = { ".git" },
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    ignore = {'W391'},
                    maxLineLength = 100
                }
            }
        }
    }
}
