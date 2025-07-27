vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- create a user command to save current buffer
vim.api.nvim_create_user_command("W", "w", {})

-- create a user command to save all buffers
vim.api.nvim_create_user_command("Wa", "wa", {})

local keymap = vim.keymap -- for conciseness

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window managment
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal widths
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) -- go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) -- go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) -- open current buffer in new tab

keymap.set("i", "<A-o>", "<esc>o", { desc = "Insert new line below and move to it" }) -- insert new line below
keymap.set("i", "<C-A-o>", "<esc>O", { desc = "Insert new line above and move to it " }) -- insert new line above

-- vertical movement
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Move up half a page and center" }) -- move up half a page and then center on screen
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Move down half a page and center" }) -- move down half a page and then center on screen

-- telescope keymaps
keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<CR>", { desc = "Search keymaps" }) -- Opens search window for keymaps

-- neorg commands
keymap.set(
  "n",
  "<leader>nr",
  ":Neorg return<CR>",
  { noremap = true, silent = true, desc = "Close all open neorg files" }
) -- close all open neorg files
keymap.set(
  "n",
  "<leader>ni",
  ":Neorg index<CR>",
  { noremap = true, silent = true, desc = "Open default neorg index file" }
) -- open default neorg index file
keymap.set(
  "i",
  "<C-o>",
  "<Plug>(neorg.itero.next-iteration)",
  { noremap = true, silent = true, desc = "Next neorg iteration or create/move to new line" }
) -- next neorg iteration
keymap.set("n", "<localleader>toc", "<cmd>Neorg toc<CR>", { desc = "Toggle neorg table of contents" }) -- toggle neorg table of contents

-- run swift project
keymap.set(
  "n",
  "<leader>rsp",
  ':wa<CR>:silent !tmux send-keys -t 0.1 "swift run" Enter<CR>',
  { desc = "Runs the current Swift project", noremap = true, silent = true }
)

-- run live server for chome and open in vertical tmux pane
keymap.set("n", "<leader>ls", function()
  vim.fn.system('tmux split-window -v "live-server --browser=\\"Google Chrome\\""')
end, { noremap = true, silent = true, desc = "Open live server in chrome" })

-- kill live server
vim.keymap.set("n", "<leader>kls", function()
  local job_id = vim.fn.systemlist("ps aux | grep live-server | grep -v grep | awk '{print $2}'")[1]
  if job_id ~= nil then
    vim.fn.system("kill " .. job_id)
    print("Live server stopped.")
  else
    print("No live server running.")
  end
end, { noremap = true, silent = true, desc = "Kill live server" })

-- floating terminal
-- Note: <c-d> will kill the terminal and a new one will be created next time it opens
vim.keymap.set({ "n", "t" }, "<leader>tt", "<cmd>Floaterminal<CR>", { desc = "Toggle floating terminal" }) -- toggle floating terminal
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Get out of terminal mode" }) -- get out of terminal mode

-- obsidian.nvim keymaps
vim.keymap.set("n", "<leader>oq", "<cmd>ObsidianQuickSwitch<CR>", { desc = "Quick switch note" }) -- switch/create Obsidian note
vim.keymap.set("n", "<leader>on", "<cmd>ObsidianNew<CR>", { desc = "Create new Obsidian note" }) -- create new Obsidian note
vim.keymap.set("n", "<leader>os", "<cmd>ObsidianSearch<CR>", { desc = "Search Obsidian vault" }) -- search Obsidian vault
vim.keymap.set("n", "<leader>ot", "<cmd>ObsidianTags<CR>", { desc = "Search Obsidian tags" }) -- search Obsidian tags

-- Intercept home row mod (Option + "n", "t") key presses
vim.keymap.set("i", "<M-t>", "<Nop>", { noremap = true, silent = true, desc = "" })
vim.keymap.set("i", "<M-n>", "<Nop>", { noremap = true, silent = true, desc = "" })

vim.keymap.set("n", "<leader>so", ":update<CR> :source<CR>", { desc = "Save and source current file" }) -- save and source current file
