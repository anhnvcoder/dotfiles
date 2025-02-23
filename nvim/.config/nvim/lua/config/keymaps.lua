-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap

-- Increment/Decrement
keymap.set("n", "+", "<C-a>", { desc = "Increment" })
keymap.set("n", "-", "<C-x>", { desc = "Decrement" })

-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d', { desc = "Delete a word backwards" })

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G", { desc = "Select all" })

-- Thoát insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
keymap.set("i", "kj", "<ESC>", { desc = "Exit insert mode with kj" })

-- Xoá highlight search
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- Thêm keymap để lưu file nhanh
vim.keymap.set("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file" })
vim.keymap.set("i", "<C-s>", "<Esc><cmd>w<CR>", { desc = "Save file" })
vim.keymap.set("n", "<D-s>", "<cmd>w<CR>", { desc = "Save file (macOS)" })
vim.keymap.set("i", "<D-s>", "<Esc><cmd>w<CR>", { desc = "Save file (macOS)" })

-- Đóng cửa sổ hiện tại
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- Thêm keymap để xem diagnostic
keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Line Diagnostics" })

-- Mở trouble để xem list errors
-- keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<CR>", { desc = "Toggle Trouble" })
-- keymap.set("n", "<leader>xd", "<cmd>Trouble document_diagnostics<CR>", { desc = "Document Diagnostics" })
-- keymap.set("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<CR>", { desc = "Workspace Diagnostics" })
-- keymap.set("n", "<leader>xl", "<cmd>Trouble loclist<CR>", { desc = "Location List" })
-- keymap.set("n", "<leader>xq", "<cmd>Trouble quickfix<CR>", { desc = "Quickfix List" })
--
-- Thụt lề cho visual mode
keymap.set("v", "<Tab>", ">gv", { desc = "Indent right" })
keymap.set("v", "<S-Tab>", "<gv", { desc = "Indent left" })

-- Thụt lề cho visual block mode
keymap.set("x", "<Tab>", ">gv", { desc = "Indent right (visual block)" })
keymap.set("x", "<S-Tab>", "<gv", { desc = "Indent left (visual block)" })

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window
