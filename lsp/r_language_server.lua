return {
    cmd = {
        "R",
        "--no-echo",
        "-e",
        "languageserver::run()"
    },
    filetypes = { "r" },
    root_markers = {
        ".git",
        ".Rproj.user",
        "*.Rproj",
    },
}
