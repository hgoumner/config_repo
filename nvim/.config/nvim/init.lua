-- neovim settings
require('user.options')
require('user.keymaps')
require('user.plugins')

vim.api.nvim_set_hl(0, 'CursorLine', {fg='', bg=''})
vim.api.nvim_set_hl(0, 'LineNrAbove', {fg='white', bg=''})
vim.api.nvim_set_hl(0, 'CursorLineNr', {fg='green', bg=''})
vim.api.nvim_set_hl(0, 'LineNrBelow', {fg='red', bg=''})

-- vim.g.python3_host_prog = '~/.local/venv/nvim/bin/python'

-- function vim.find_files_from_project_git_root()
--     local function is_git_repo()
--         vim.fn.system("git rev-parse --is-inside-work-tree")
--         return vim.v.shell_error == 0
--     end
--     local function get_git_root()
--         local dot_git_path = vim.fn.finddir(".git", ".;")
--         return vim.fn.fnamemodify(dot_git_path, ":h")
--     end
--     local opts = {}
--     if is_git_repo() then
--         opts = {
--             cwd = get_git_root(),
--         }
--     end
--     require("telescope.builtin").find_files(opts)
-- end

function live_grep_from_project_git_root()
	local function is_git_repo()
		vim.fn.system("git rev-parse --is-inside-work-tree")

		return vim.v.shell_error == 0
	end

	local function get_git_root()
		local dot_git_path = vim.fn.finddir(".git", ".;")
		return vim.fn.fnamemodify(dot_git_path, ":h")
	end

	local opts = {}

	if is_git_repo() then
		opts = {
			cwd = get_git_root(),
		}
	end

	require("telescope.builtin").live_grep(opts)
end
