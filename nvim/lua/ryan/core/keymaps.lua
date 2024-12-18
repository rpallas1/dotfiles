vim.g.mapleader = " "

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

-- vertical movement
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Move up half a page and center" }) -- move up half a page and then center on screen
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Move down half a page and center" }) -- move down half a page and then center on screen

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
