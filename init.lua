require("configs")
require("keymaps")
require("autocmds")
require("plugins")
require("lsp")
require("statusline")
require("colors")

-- temp

local function cycle_base16(direction)
    local themes = vim.fn.getcompletion("", "color")
    if #themes == 0 then
        print("no base 16 themes found")
        return
    end

    local current_theme = vim.g.colors_name or ""
    local index = 0
    for i, theme in ipairs(themes) do
        if theme == current_theme then
            index = i
            break
        end
    end

    index = index + direction
    if index > #themes then index = 1 end
    if index < 1 then index = #themes end

    local next_theme = themes[index]
    vim.cmd("colorscheme " .. next_theme)
    print("theme: " .. next_theme)
end

vim.keymap.set("n", "<M-n>", function() cycle_base16(1) end, { desc = "next base16 theme" })
vim.keymap.set("n", "<M-m>", function() cycle_base16(-1) end, { desc = "next base16 theme" })


-- light themes
-- equiliblirium-light
-- measured-light
--
-- dark themes
-- sandcastle
-- shadesmear-dark
