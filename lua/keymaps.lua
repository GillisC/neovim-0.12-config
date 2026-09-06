local keymap = vim.keymap.set
local s = { silent = true }

vim.g.mapleader = " "

keymap("n", "<space>", "<Nop>")

-- Makes it so that wrapped text is easier to navigate
keymap("n", "j", function()
    return tonumber(vim.api.nvim_get_vvar("count")) > 0 and "j" or "gj"
end, { expr = true, silent = true })
keymap("n", "k", function()
    return tonumber(vim.api.nvim_get_vvar("count")) > 0 and "k" or "gk"
end, { expr = true, silent = true })

keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "<Leader>w", "<cmd>w!<CR>", s)
keymap("n", "<Leader>q", "<cmd>q<CR>", s)
keymap("n", "<Leader>te", "<cmd>tabnew<CR>", s)
keymap("n", "<Leader>_", "<cmd>vsplit<CR>", s)
keymap("n", "<Leader>-", "<cmd>split<CR>", s)
keymap("n", "<Leader>fo", ":lua vim.lsp.buf.format()<CR>", s)
keymap("v", "<Leader>p", '"_dP')
keymap("x", "y", [["+y]], s)
keymap("t", "<Esc>", "<C-\\><C-N>")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

keymap("n", "<leader>cd", '<cmd>lua vim.fn.chdir(vim.fn.expand("%:p:h"))<CR>')
keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")

local opts = { noremap = true, silent = true }
keymap("n", "grd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)

keymap("n", "<Leader>e", "<cmd>Ex %:p:h<CR>")

keymap("n", "<Leader>ff", "<cmd>FzfLua files<CR>")
keymap("n", "<Leader>fg", "<cmd>FzfLua live_grep<CR>")

keymap("n", "<Leader>ch" , function()
    local curr_file = vim.fn.expand("%:p")
    vim.fn.system("chmod +x " .. curr_file)
    print("file permissions: " .. vim.fn.system("ls -l " .. curr_file))
end)

local compilation_buf = nil
local compilation_job = nil

local function create_compilation_terminal()
    vim.cmd("leftabove vsplit")
    vim.cmd("enew")

    compilation_buf = vim.api.nvim_get_current_buf()

    vim.api.nvim_buf_set_name(compilation_buf, "Compilation")

    compilation_job = vim.fn.jobstart({
        "bash",
        "--noprofile",
        "--norc",
    }, {
        term = true,
        env = {
            PS1 = "",
        },
    })
end

keymap("n", "<Leader>ma", function()
    local source_win = vim.api.nvim_get_current_win()

    -- Compilation terminal doesn't exist yet
    if compilation_buf == nil or not vim.api.nvim_buf_is_valid(compilation_buf) then
        create_compilation_terminal()
    else
        -- Compilation buffer exists, but its window is closed
        local win = vim.fn.bufwinnr(compilation_buf)

        if win == -1 then
            vim.cmd("leftabove vsplit")
            vim.api.nvim_win_set_buf(0, compilation_buf)
        else
            -- Compilation window already exists
            vim.api.nvim_set_current_win(vim.fn.win_getid(win))
        end
    end

    -- Run make in the persistent shell
    vim.fn.chansend(compilation_job,
        "clear; make; status=$?; if [ $status -eq 0 ]; then echo; printf '\\033[32mCompilation successful!\\033[0m\\n'; else echo; printf '\\033[31mCompilation failed!\\033[0m\\n'; fi\n"
    )

    -- Return to the source window
    vim.api.nvim_set_current_win(source_win)
end)

keymap("n", "<C-j>", "<cmd>cnext<CR>")
keymap("n", "<C-k>", "<cmd>cprev<CR>")
