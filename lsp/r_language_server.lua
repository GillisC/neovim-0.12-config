return {
    cmd = {
        "R",
        "--no-echo",
        "-e",
        "languageserver::run()"
    },
    filetypes = { "r", "qmd", "Rmd" },
    root_markers = {
        ".git",
        ".Rproj.user",
        "*.Rproj",
    },
}
